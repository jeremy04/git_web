class ImportGitLog
  GIT_LOG_REGEX    = /commit\s(\w+)\n(?:Merge.*?\n)*Author:\s(.*?)\s<(.*?)>\nDate:(.*?)\n\n(.*?)\n\n(?=commit)/m
  LAST_OCCUR_REGEX = /commit\s(\w+)\n(?:Merge.*?\n)*Author:\s(.*?)\s<(.*?)>\nDate:(.*?)\n\n(.*)/m
  BUG_REGEX        = /cr\s(?:#|number\s)?(\d+)/i

  def call(file)
    commits = parse(file)
    import(commits)
  end

  def parse(file)
    string = File.read(file).gsub("\r","")
    commits = extract_log(string, GIT_LOG_REGEX)
    remaining = string.gsub(GIT_LOG_REGEX,"")
    commits += extract_log(remaining, LAST_OCCUR_REGEX)
    commits
  end

  def import(commits)
    commits.each do |commit|
      ActiveRecord::Base.transaction do
        author = Author.find_or_create_by(name: commit[:author], 
                                          email: commit[:email])
        bug = Bug.create!(cr_number: $1) if commit[:message] =~ BUG_REGEX
        commit = Commit.create!(commit_hash: commit[:commit_hash], 
                                message: commit[:message], 
                                committed_at: Time.parse(commit[:date]), 
                                author: author,
                                bug: bug 
                                )
      end
    end
  end

  private

  def extract_log(string, regex)
     commits = []
     string.scan(regex).each do |match|
      commits << {
                  commit_hash: match[0],
                  author:      match[1],
                  email:       match[2],
                  date:        match[3].strip,
                  message:     match[4].strip, 
                 }
    end
    commits
  end

end

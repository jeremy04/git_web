require "rails_helper"

describe "Import" do

  describe "#parse" do
    it "can parse one git commit" do
      log = """
commit 0662da725f942fdf0892fae5a44944e538bb3fe4
Author: John Doe <John.Doe@raritan.com>
Date:   Tue Mar 20 17:16:23 2012 -0400

    rollup interval converter testing
      """
      File.stub(:read).with("some_file").and_return(log)
      ImportGitLog.new.parse("some_file").should ==
       [{commit_hash: "0662da725f942fdf0892fae5a44944e538bb3fe4",
         author: "John Doe", 
         email: "John.Doe@raritan.com", 
         date: "Tue Mar 20 17:16:23 2012 -0400",
         message: "rollup interval converter testing"
        }]
    end

    it "can parse one git commit with new lines" do
      log = """
commit efda6c44c8b96665130eda0f20004b6e486d0774
Author: Mike Smith <mike@somedomain.com>
Date:   Wed Mar 14 16:00:14 2012 -0400

    CR number 38161. Fixing regular expression for matching IPv4 addresses.


      """
      File.stub(:read).with("some_file").and_return(log)
      ImportGitLog.new.parse("some_file").should ==
       [{commit_hash: "efda6c44c8b96665130eda0f20004b6e486d0774",
          author: "Mike Smith", 
          email: "mike@somedomain.com", 
          date: "Wed Mar 14 16:00:14 2012 -0400",
          message: "CR number 38161. Fixing regular expression for matching IPv4 addresses."
        }]
    end

    it "can parse two commits" do
      log = """
commit 0662da725f942fdf0892fae5a44944e538bb3fe4
Author: John Doe <John.Doe@raritan.com>
Date:   Tue Mar 20 17:16:23 2012 -0400

    rollup interval converter testing

commit efda6c44c8b96665130eda0f20004b6e486d0774
Author: Mike Smith <mike@somedomain.com>
Date:   Wed Mar 14 16:00:14 2012 -0400

    CR number 38161. Fixing regular expression for matching IPv4 addresses.


      """
      File.stub(:read).with("some_file").and_return(log)
      ImportGitLog.new.parse("some_file").should ==
       [{commit_hash: "0662da725f942fdf0892fae5a44944e538bb3fe4",
         author: "John Doe", 
         email: "John.Doe@raritan.com", 
         date: "Tue Mar 20 17:16:23 2012 -0400",
         message: "rollup interval converter testing"
        },
        {commit_hash: "efda6c44c8b96665130eda0f20004b6e486d0774",
          author: "Mike Smith", 
          email: "mike@somedomain.com", 
          date: "Wed Mar 14 16:00:14 2012 -0400",
          message: "CR number 38161. Fixing regular expression for matching IPv4 addresses."
        }]
    end

  end

end

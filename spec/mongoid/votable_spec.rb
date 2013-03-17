require 'spec_helper'

module Mongoid
  describe Votable do    
    it { Topic.should respond_to(:voted_by) }
    
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:topic) { create(:topic) }
    
    subject { topic }
        
    it { should respond_to(:votes, :votes_count, :votes_up, :votes_down, :votes_average) }
    
    its(:votes_count) { should == 0 }
    its(:votes_up) { should == 0 }
    its(:votes_down) { should == 0 }
    its(:votes_average) { should == 0 }
    its(:votes) { should be_empty }
    
    context "single user" do 
    
      context "user vote up" do
        before(:each) { topic.vote!(1, user) }
        its(:votes_count) { should == 1 }
        its(:votes_up) { should == 1 }
        its(:votes_down) { should == 0 }
        its(:votes_average) { should == 1 }
        its(:votes) { should_not be_empty }
      end
    
      context "user vote down" do
        before(:each) { topic.vote!(-1, user) }
        its(:votes_count) { should == 1 }
        its(:votes_up) { should == 0 }
        its(:votes_down) { should == 1 }
        its(:votes_average) { should == -1 }
        its(:votes) { should_not be_empty }
      end
    
      context "user vote up, then vote down with same value" do
        before(:each) do 
          topic.vote!(3, user) 
          topic.vote!(-3, user) 
        end
        its(:votes_count) { should == 0 }
        its(:votes_up) { should == 0 }
        its(:votes_down) { should == 0 }
        its(:votes_average) { should == 0 }
        its(:votes) { should be_empty }
      end
    
      context "user vote up, then vote down, (down > up)" do
        before(:each) do 
          topic.vote!(3, user) 
          topic.vote!(-6, user) 
        end
        its(:votes_count) { should == 1 }
        its(:votes_up) { should == 0 }
        its(:votes_down) { should == 1 }
        its(:votes_average) { should == -3 }
        its(:votes) { should_not be_empty }
      end    
    
      context "user vote up, then vote down, (down < up)" do
        before(:each) do 
          topic.vote!(3, user) 
          topic.vote!(-1, user) 
        end
        its(:votes_count) { should == 1 }
        its(:votes_up) { should == 1 }
        its(:votes_down) { should == 0 }
        its(:votes_average) { should == 2 }
        its(:votes) { should_not be_empty }
      end  
    
    end
    
    context "multiple users" do 
    
      context "users all vote up" do
        before(:each) do
          topic.vote!(1, user) 
          topic.vote!(1, user2) 
        end
        its(:votes_count) { should == 2 }
        its(:votes_up) { should == 2 }
        its(:votes_down) { should == 0 }
        its(:votes_average) { should == 2 }
        its(:votes) { should have(2).items }
      end
      
      context "users all vote down" do
        before(:each) do
          topic.vote!(-1, user) 
          topic.vote!(-1, user2) 
        end
        its(:votes_count) { should == 2 }
        its(:votes_up) { should == 0 }
        its(:votes_down) { should == 2 }
        its(:votes_average) { should == -2 }
        its(:votes) { should have(2).items }
      end
      
      context "users with different votes" do
        before(:each) do
          topic.vote!(1, user) 
          topic.vote!(-1, user2) 
        end
        its(:votes_count) { should == 2 }
        its(:votes_up) { should == 1 }
        its(:votes_down) { should == 1 }
        its(:votes_average) { should == 0 }
        its(:votes) { should have(2).items }
      end
      
      context "users with different votes" do
        before(:each) do
          topic.vote!(1, user) 
          topic.vote!(-2, user2) 
        end
        its(:votes_count) { should == 2 }
        its(:votes_up) { should == 1 }
        its(:votes_down) { should == 1 }
        its(:votes_average) { should == -1 }
        its(:votes) { should have(2).items }
      end
    
    end
    
    context "voted_by" do 
      before(:each) do
        topic.vote!(1, user) 
        topic.vote!(1, user2) 
      end
      subject { Topic.voted_by(user) }
      
      it { should have(1).items }      
      its(:first) { should be_instance_of Topic }      
    end
    
    context "voted?" do
      before(:each) { topic.vote!(1, user) }
      it { topic.voted?(user).should be_true }
      it { topic.voted?(user2).should be_false }
    end    
        
  end 
end

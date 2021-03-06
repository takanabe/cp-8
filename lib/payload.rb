require "json"

class Payload < Hashie::Mash
  def self.new_from_json(raw_json)
    new JSON.parse(raw_json)
  end

  def process
    if pull_request?
      Events::PullRequestUpdate.new(self).process
    elsif issue?
      Events::IssueUpdate.new(self).process
    end
  end
end

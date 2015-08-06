require 'rails_helper'

describe TopicManager do
  let(:message) { "Add lots of buzzwords to project #relaunch: fix, css, js, javascript" }
  correct_topics = %w(
    relaunch
    fix
    css
    js
  )
  let(:node) { Graph::Github::Commit.find_or_create( {sha: SecureRandom.hex}, {message: message}) }

  let(:manager) { TopicManager.new(node) }
  let(:topics) { manager.assign_topics(node.message) }

  subject { topics; node.reload.topics.to_a }
  it "should be an array" do
    expect(subject).to be_a(Array)
  end

  it 'creates topic nodes' do
    expect(subject).not_to be_empty
  end

  it 'creates a node for all the topics' do
    expect(subject.map(&:name)).to match_array(correct_topics)
  end

end

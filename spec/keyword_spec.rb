require 'spec_helper'

describe TMS::Keyword do
  context "creating a new keyword" do
    let(:client) do
      double('client')
    end
    before do
      @keyword = TMS::Keyword.new(client, nil, {:name => 'LOL'})
    end
    it 'should initialize with attrs' do
      @keyword.name.should == 'LOL'
    end
    it 'should post successfully' do
      response = {:name => 'lol'}
      @keyword.client.should_receive('post').with(@keyword).and_return(double('response', :status => 201, :body => response))
      @keyword.post
      @keyword.name.should == 'lol'
    end
    it 'should handle errors' do
      response = {'errors' => {:name => "can't be nil"}}
      @keyword.client.should_receive('post').with(@keyword).and_return(double('response', :status => 422, :body => response))
      @keyword.post
      @keyword.name.should == 'LOL'
      @keyword.errors.should == {:name => "can't be nil"}
    end
  end

  context 'an existing keyword' do
    let(:client) do
      double('client')
    end
    before do
      # blank hash prevents the client from doing a GET in the initialize method
      @keyword = TMS::Keyword.new(client, '/keywords/99', {})
    end
    it 'should GET cleanly' do
      response = {:name => 'FOO'}
      @keyword.client.should_receive('get').with(@keyword.href).and_return(double('response', :status => 200, :body => response))
      @keyword.get
      @keyword.name.should == 'FOO'
    end
    it 'should PUT cleanly' do
      @keyword.name = "GOVLIE"
      response  = {:name => 'govlie'}
      @keyword.client.should_receive('put').with(@keyword).and_return(double('response', :status => 200, :body => response))
      @keyword.put
      @keyword.name.should == 'govlie'

    end
    it 'should DELETE cleanly' do
      @keyword.client.should_receive('delete').with(@keyword.href).and_return(double('response', :status => 200, :body => ''))
      @keyword.delete
    end
  end


end

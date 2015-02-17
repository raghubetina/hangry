namespace :mturk do
  desc "Post jobs to Amazon Turk"
  task :hire => :environment do
    #!/usr/bin/env ruby

    # Copyright:: Copyright (c) 2007 Amazon Technologies, Inc.
    # License::   Apache License, Version 2.0

    begin ; require 'rubygems' ; rescue LoadError ; end

    # The MTurk Hello World sample application creates a simple HIT via Libraries for Amazon Web Services.

    require 'ruby-aws'
    @mturk = Amazon::WebServices::MechanicalTurkRequester.new :Host => :Sandbox

    require 'amazon/webservices/mturk/question_generator'
    include Amazon::WebServices::MTurk

    def post_job(name, phone_number, group_number)
      title = "Call restaurant for wait times"
      desc = "This is a HIT created by the Amazon Mechanical Turk SDK for Ruby.  Please answer the question."
      keywords = "sample, SDK, hello"
      numAssignments = 1
      rewardAmount = 0.05 # 5 cents

      # question = QuestionGenerator.build(:Basic) do |q|
      #   q.ask "What is the weather like right now in Seattle, WA?"
      # end

      source = "<?xml version=\"1.0\"?>
    <QuestionForm xmlns=\"http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionForm.xsd\">
      <Overview>
        <FormattedContent><![CDATA[
          <h1 align=\"center\">Select the best image</h1>
          <h2>Instructions</h2>
          Your task is to call a restaurant using the provided number and find out wait time for a specific number of people
          <h3>Evaluation Criteria</h3>
            <ul>
              <li>Please submit the answer in minutes</li>
              <li>Please just include a number, not 'min' or 'minutes'</li>
            </ul>
          <h2>Task</h2>
        ]]></FormattedContent>
      </Overview>
      <Question>
        <QuestionIdentifier>wait_time</QuestionIdentifier>
        <IsRequired>true</IsRequired>
        <QuestionContent>
          <FormattedContent><![CDATA[
          <font size=\"4\" color=\"darkblue\" >Please call #{name} at #{Phony.format(phone_number)}</font><br/><br/>
          <font size=\"3\" color=\"darkblue\" >Find out the wait time for a group of #{group_number}</font><br/>
          ]]></FormattedContent>
          <Text>Enter the wait time below:</Text>
        </QuestionContent>
        <AnswerSpecification>
          <FreeTextAnswer>
            <NumberOfLinesSuggestion>1</NumberOfLinesSuggestion>
          </FreeTextAnswer>
        </AnswerSpecification>
      </Question>
      <Question>
        <QuestionIdentifier>comments</QuestionIdentifier>
        <QuestionContent>
          <Text>Please help us improve this HIT by including any Questions and/or Comments (optional):</Text>
        </QuestionContent>
        <AnswerSpecification>
          <FreeTextAnswer>
            <NumberOfLinesSuggestion>10</NumberOfLinesSuggestion>
          </FreeTextAnswer>
        </AnswerSpecification>
      </Question>
    </QuestionForm>"

    doc = Nokogiri::XML source


     question = doc.to_xml

     result = @mturk.createHIT( :Title => title,
      :Description => desc,
      :MaxAssignments => numAssignments,
      :Reward => { :Amount => rewardAmount, :CurrencyCode => 'USD' },
      :Question => question,
      :Keywords => keywords )


     puts "Created HIT: #{result[:HITId]}"
     puts "Url: #{getHITUrl( result[:HITTypeId] )}"
    end

    def getHITUrl( hitTypeId )
      if @mturk.host =~ /sandbox/
        "http://workersandbox.mturk.com/mturk/preview?groupId=#{hitTypeId}" # Sandbox Url
      else
        "http://mturk.com/mturk/preview?groupId=#{hitTypeId}" # Production Url
      end
    end

    # Check to see if your account has sufficient funds
    def hasEnoughFunds?
      available = @mturk.availableFunds
      puts "Got account balance: %.2f" % available
      return available > 0.055
    end

    Restaurant.all.each do |restaurant|
      post_job(restaurant.name, restaurant.phone_number, 4) if hasEnoughFunds?
    end

    # createHelloWorld if hasEnoughFunds?

  end
end

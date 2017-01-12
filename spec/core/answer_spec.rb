require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::Answer do

	let(:answer){
		
		OSCRuby::Answer.new

	}

	context '#initialize' do

		it 'should not throw an error when initialized' do

			expect{answer}.not_to raise_error

		end

		it 'should initialize with answerType as a hash, language as a hash, and summary as a string' do

			expect(answer.answerType).to eq({})

			expect(answer.language).to eq({})

			expect(answer.summary).to eq('Answer summary text')

		end

	end

	let(:attributes){
		{
		"id"=> 2222,
		"lookupName"=> 2222,
		"createdTime"=> "2014-02-05T23:42:28Z",
		"updatedTime"=> "2016-12-13T09:55:45Z",
		"accessLevels"=> 3,
		"adminLastAccessTime"=> "2016-11-23T22:54:26Z",
		"answerType"=> 1,
		"expiresDate"=> nil,
		"guidedAssistance"=> nil,
		"keywords"=> "AbCbEbAb",
		"language"=> 1,
		"lastAccessTime"=> "2016-12-10T07:27:37Z",
		"lastNotificationTime"=> nil,
		"name"=> 2222,
		"nextNotificationTime"=> nil,
		"originalReferenceNumber"=> nil,
		"positionInList"=> 1,
		"publishOnDate"=> nil,
		"question"=> nil,
		"solution"=> "<p ></iframe></p>\n<ol>\n<li>\n<div class=\"MsoNormal\" >The following video will show you how to view your DVR using the QT view app or through a Browser using the Q-See Scan n View P2P technology.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step1.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >P2P equals Peer to Peer. This concept has been around for a long time.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step2.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >P2P equals Peer to Peer. In a peer to peer network, tasks (such as searching for files or streaming audio/video) are shared amongst multiple interconnected peers who each make a portion of their resources (such as processing power, Disk Storage or network bandwidth) directly available to other Network participants, without the need for centralized coordination by servers.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step3.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Q-See's application is to take the Port Forwarding process out of the hands of the End User.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step4.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Next, you will need to install your QT View app via the Apple App Store or the Google Play Store.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step5.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Once the DVR is connected and is powered up, you will go through the wizard.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6a.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6b.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6c.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >While going through the wizard you will need to select your device to fit the the QR Code.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6d.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6e.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then go to your QT View and tap on the QR code image.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step7.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Now, your scanner will come up, then scan the QR code.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step8.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >The MAC address will appear, then enter the DVR's user name and password.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step9.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then Tap Login.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step10.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >After a few moments you will then be able to see the cameras without having to access the router.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step11.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >How to access it for PC/MAC.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step12.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Open Browser. Enter qtview.com, Push enter. NOTE: YOU WILL STILL NEED TO ADD IN THE ACTIVE X OR IE PLUG IN FOR YOUR BROWSER.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step13.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Enter the MAC address, User name, and Password, then click LOGIN.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step14.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then you will be able to see your system.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step15.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Q-See Scan n View.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step16.png\" /></p>\n</li>\n</ol>",
		"summary"=> "QT Series: (VIDEO) Scan 'N View Setup",
		"updatedByAccount"=> 47,
		"uRL"=> nil
		}
	}

	context '#new_from_fetch' do

		it 'should accept an attributes as a hash' do

			expect do

				attributes = []

				OSCRuby::Answer.new_from_fetch(attributes)

			end.to raise_error("Attributes must be a hash; please use the appropriate data structure")

			expect do

				OSCRuby::Answer.new_from_fetch(attributes)

			end.not_to raise_error

		end

		it 'should instantiate an id, lookupName, createdTime, updatedTime, accessLevels, adminLastAccessTime, answerType, expiresDate, guidedAssistance, keywords, language, lastAccessTime, lastNotificationTime, name, nextNotificationTime, originalReferenceNumber, positionInList, publishOnDate, question, solution, summary, updatedByAccount, uRL with the correct values' do

			test = OSCRuby::Answer.new_from_fetch(attributes)

			expect(test.id).to eq(2222)
			expect(test.lookupName).to eq(2222)
			expect(test.createdTime).to eq("2014-02-05T23:42:28Z")
			expect(test.updatedTime).to eq("2016-12-13T09:55:45Z")
			expect(test.accessLevels).to eq(3)
			expect(test.adminLastAccessTime).to eq("2016-11-23T22:54:26Z")
			expect(test.answerType).to eq(1)
			expect(test.expiresDate).to eq(nil)
			expect(test.guidedAssistance).to eq(nil)
			expect(test.keywords).to eq("AbCbEbAb")
			expect(test.language).to eq(1)
			expect(test.lastAccessTime).to eq("2016-12-10T07:27:37Z")
			expect(test.lastNotificationTime).to eq(nil)
			expect(test.name).to eq(2222)
			expect(test.nextNotificationTime).to eq(nil)
			expect(test.originalReferenceNumber).to eq(nil)
			expect(test.positionInList).to eq(1)
			expect(test.publishOnDate).to eq(nil)
			expect(test.question).to eq(nil)
			expect(test.solution).to eq("<p ></iframe></p>\n<ol>\n<li>\n<div class=\"MsoNormal\" >The following video will show you how to view your DVR using the QT view app or through a Browser using the Q-See Scan n View P2P technology.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step1.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >P2P equals Peer to Peer. This concept has been around for a long time.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step2.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >P2P equals Peer to Peer. In a peer to peer network, tasks (such as searching for files or streaming audio/video) are shared amongst multiple interconnected peers who each make a portion of their resources (such as processing power, Disk Storage or network bandwidth) directly available to other Network participants, without the need for centralized coordination by servers.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step3.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Q-See's application is to take the Port Forwarding process out of the hands of the End User.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step4.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Next, you will need to install your QT View app via the Apple App Store or the Google Play Store.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step5.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Once the DVR is connected and is powered up, you will go through the wizard.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6a.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6b.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6c.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >While going through the wizard you will need to select your device to fit the the QR Code.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6d.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6e.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then go to your QT View and tap on the QR code image.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step7.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Now, your scanner will come up, then scan the QR code.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step8.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >The MAC address will appear, then enter the DVR's user name and password.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step9.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then Tap Login.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step10.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >After a few moments you will then be able to see the cameras without having to access the router.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step11.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >How to access it for PC/MAC.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step12.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Open Browser. Enter qtview.com, Push enter. NOTE: YOU WILL STILL NEED TO ADD IN THE ACTIVE X OR IE PLUG IN FOR YOUR BROWSER.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step13.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Enter the MAC address, User name, and Password, then click LOGIN.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step14.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then you will be able to see your system.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step15.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Q-See Scan n View.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step16.png\" /></p>\n</li>\n</ol>")
			expect(test.summary).to eq("QT Series: (VIDEO) Scan 'N View Setup")
			expect(test.updatedByAccount).to eq(47)
			expect(test.uRL).to eq(nil)

		end

	end

	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_TEST_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']
		
		end
	}

	let(:new_answer){
		OSCRuby::Answer.new
	}

	context '#create' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{new_answer.create(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should check the object and make sure that it at least has a language, answerType, and summary set' do

			expect{new_answer.create(client)}.to raise_error('Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")')

			new_answer.language['id'] = 1

			expect{new_answer.create(client)}.to raise_error('Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")')

			new_answer.answerType['id'] = 1

			# the Answer summary is defaulted to "Answer summary text" so it should pass here

			expect{new_answer.create(client)}.to_not raise_error

		end

		it 'should expect the language as a hash with an id as a key with a value of a number' do

			new_answer.language['id'] = "new product name"
			new_answer.answerType['id'] = 1

			expect{new_answer.create(client)}.to raise_error('Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")')

		end

		it 'should expect the answerType as a hash with an id as a key with a value of a number' do

			new_answer.language['id'] = 1
			new_answer.answerType['id'] = "new product name"

			expect{new_answer.create(client)}.to raise_error('Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")')

		end

		it 'should expect the answerType as a hash with an lookupName as a key with a value of "HTML","URL", or "File Attachment"' do

			new_answer.language['id'] = 1
			new_answer.answerType['lookupName'] = "HTML"

			expect{new_answer.create(client)}.not_to raise_error

		end

		it 'should return an instance of an OSCRuby::Answer if the json_response param is set to false (which it is by default)', :vcr do

			new_answer.language['id'] = 1
			new_answer.answerType['lookupName'] = "HTML"

			new_answer.create(client)

			expect(new_answer).to be_a(OSCRuby::Answer)

			expect(new_answer.summary).to eq("Answer summary text")

			expect(new_answer.language).to eq({"id"=>1, "lookupName"=>"en_US"})

		end


		it 'should return the body object if the json_response param is set to true', :vcr do

			new_answer.language['id'] = 1
			new_answer.answerType['lookupName'] = "HTML"

			expect(new_answer.create(client,true)).to be_a(String)

		end

	end

	context '#find' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{OSCRuby::Answer.find(client,100)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should raise an error if ID is undefined' do

			expect{OSCRuby::Answer.find(client)}.to raise_error('ID cannot be nil')

		end

		it 'should raise an error if ID is not an integer' do

			expect{OSCRuby::Answer.find(client, 'a')}.to raise_error('ID must be an integer')

		end

		it 'should return a warning if empty/no instances of the object can be found', :vcr do

			expect{OSCRuby::Answer.find(client, 100)}.to raise_error('There were no objects matching your query; please try again.')

		end


		it 'should return an instance of a new OSCRuby::Answer object with at least a name and displayOrder', :vcr do
		
			known_working_product = OSCRuby::Answer.find(client, 2222)

			expect(known_working_product).to be_an(OSCRuby::Answer)
			expect(known_working_product.id).to eq(2222)
			expect(known_working_product.lookupName).to eq(2222)
			expect(known_working_product.createdTime).to eq("2014-02-05T23:42:28Z")
			expect(known_working_product.updatedTime).to eq("2016-12-13T09:55:45Z")
			expect(known_working_product.accessLevels).to eq(3)
			expect(known_working_product.adminLastAccessTime).to eq("2016-11-23T22:54:26Z")
			expect(known_working_product.answerType).to eq(1)
			expect(known_working_product.expiresDate).to eq(nil)
			expect(known_working_product.guidedAssistance).to eq(nil)
			expect(known_working_product.keywords).to eq("AbCbEbAb")
			expect(known_working_product.language).to eq(1)
			expect(known_working_product.lastAccessTime).to eq("2016-12-10T07:27:37Z")
			expect(known_working_product.lastNotificationTime).to eq(nil)
			expect(known_working_product.name).to eq(2222)
			expect(known_working_product.nextNotificationTime).to eq(nil)
			expect(known_working_product.originalReferenceNumber).to eq(nil)
			expect(known_working_product.positionInList).to eq(1)
			expect(known_working_product.publishOnDate).to eq(nil)
			expect(known_working_product.question).to eq(nil)
			expect(known_working_product.solution).to eq("<p ></iframe></p>\n<ol>\n<li>\n<div class=\"MsoNormal\" >The following video will show you how to view your DVR using the QT view app or through a Browser using the Q-See Scan n View P2P technology.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step1.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >P2P equals Peer to Peer. This concept has been around for a long time.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step2.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >P2P equals Peer to Peer. In a peer to peer network, tasks (such as searching for files or streaming audio/video) are shared amongst multiple interconnected peers who each make a portion of their resources (such as processing power, Disk Storage or network bandwidth) directly available to other Network participants, without the need for centralized coordination by servers.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step3.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Q-See's application is to take the Port Forwarding process out of the hands of the End User.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step4.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Next, you will need to install your QT View app via the Apple App Store or the Google Play Store.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step5.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Once the DVR is connected and is powered up, you will go through the wizard.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6a.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6b.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6c.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >While going through the wizard you will need to select your device to fit the the QR Code.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6d.png\" /></p>\n<div class=\"MsoNormal\" ></div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step6e.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then go to your QT View and tap on the QR code image.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step7.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Now, your scanner will come up, then scan the QR code.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step8.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >The MAC address will appear, then enter the DVR's user name and password.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step9.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then Tap Login.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step10.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >After a few moments you will then be able to see the cameras without having to access the router.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step11.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >How to access it for PC/MAC.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step12.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Open Browser. Enter qtview.com, Push enter. NOTE: YOU WILL STILL NEED TO ADD IN THE ACTIVE X OR IE PLUG IN FOR YOUR BROWSER.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step13.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Enter the MAC address, User name, and Password, then click LOGIN.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step14.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Then you will be able to see your system.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step15.png\" /></p>\n</li>\n<li>\n<div class=\"MsoNormal\" >Q-See Scan n View.</div>\n<p align=\"center\"><img border=\"0\" alt=\"Image\" src=\"//q-see.s3.amazonaws.com/content/files/HowToFiles/p2pimages/Step16.png\" /></p>\n</li>\n</ol>")
			expect(known_working_product.summary).to eq("QT Series: (VIDEO) Scan 'N View Setup")
			expect(known_working_product.updatedByAccount).to eq(47)
			expect(known_working_product.uRL).to eq(nil)

		end

		it 'should return the raw json response if the return_json parameter is set to true', :vcr do

			known_working_product_in_json = OSCRuby::Answer.find(client, 2222, true)

			expect(known_working_product_in_json).to be_an(String)

		end

	end

	# context '#all' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{OSCRuby::Answer.all(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should return multiple instances of OSCRuby::Answer', :vcr do

	# 		products = OSCRuby::Answer.all(client)

	# 		expect(products.size).to be > 0

	# 		# puts "Checking if OSCRuby::Answer.all produces multiple instances of products"

	# 		products.each_with_index do |p,i|

	# 			if i < 10

	# 				expect(p).to be_an(OSCRuby::Answer)

	# 				# puts p.name

	# 			end

	# 		end

	# 	end

	# 	it 'should just return JSON if the return_json parameter is set to true', :vcr do

	# 		expect(OSCRuby::Answer.all(client,true)).to be_a(String)

	# 	end

	# end

	# context '#where' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{OSCRuby::Answer.where(client,'query')}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should raise an error if there is no query' do

	# 		expect{OSCRuby::Answer.where(client)}.to raise_error('A query must be specified when using the "where" method')

	# 	end

	# 	it 'should take a query and return results', :vcr do

	# 		products_lvl_1 = OSCRuby::Answer.where(client,"parent is null and lookupname not like 'Unsure'")

	# 		expect(products_lvl_1.count).to be > 0

	# 		products_lvl_1.each_with_index do |p,i|

	# 			if i < 10

	# 				expect(p).to be_an(OSCRuby::Answer)

	# 				# puts p.name

	# 			end

	# 		end

	# 	end

	# 	it 'should raise an error if the query returns 0 results', :vcr do

	# 		expect{OSCRuby::Answer.where(client,"parent = 6546546546546")}.to raise_error('There were no objects matching your query; please try again.')

	# 	end

	# 	it 'should just return JSON if the return_json parameter is set to true', :vcr do

	# 		parents = OSCRuby::Answer.where(client,"parent is null and lookupname not like 'Unsure'",true)

	# 		expect(parents).to be_a(String)

	# 		# puts parents

	# 	end

	# end

	# context '#update' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{known_working_product.update(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should expect that the Service Product is an instance of a OSCRuby::Answer', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		expect(known_working_product).to be_an(OSCRuby::Answer)

	# 	end

	# 	it 'should expect that the product has an ID and spit out an error if it does not', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		known_working_product.id = nil

	# 		expect{known_working_product.destroy(client)}.to raise_error('OSCRuby::Answer must have a valid ID set')
		
	# 	end

	# 	it 'should update name when the names is updated', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT'")
	# 		first_prod = test_prods[0]

	# 		first_prod.names[0] = {"labelText" => "TEST-PRODUCT-UPDATED", "language" => {"id" => 1}}

	# 		first_prod.update(client)

	# 		expect(first_prod.name).to eq('TEST-PRODUCT-UPDATED')

	# 	end

	# 	it 'should just return JSON if the return_json parameter is set to true', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		test = known_working_product.update(client,true)

	# 		expect(test).to be_a(String)

	# 	end

	# end

	# context '#destroy' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{product_to_delete.destroy(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should expect that the Service Product is an instance of a OSCRuby::Answer', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		expect(product_to_delete).to be_an(OSCRuby::Answer)

	# 	end

	# 	it 'should expect that the product has an ID and spit out an error if it does not', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		product_to_delete.id = nil

	# 		expect{product_to_delete.destroy(client)}.to raise_error('OSCRuby::Answer must have a valid ID set')
		
	# 	end

	# 	it 'should delete the product', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		id_to_find = product_to_delete.id

	# 		product_to_delete.destroy(client)

	# 		expect{OSCRuby::Answer.find(client, id_to_find)}.to raise_error('There were no objects matching your query; please try again.')
		
	# 	end

	# end

end
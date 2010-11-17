$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require "tokie"
require "xmlsimple"

client = Tokie::Client.new(1, "7198834839384aef315f2ae70bfd3bb43")
client.generate_token :permissions => ["createSession"]

xml = client.create_session.body
puts XmlSimple.xml_in(xml)

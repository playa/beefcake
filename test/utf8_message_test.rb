#coding: utf-8
require 'beefcake'
class SimpleMessage
  include Beefcake::Message

  optional :a, :int32,  1
  optional :b, :string, 2
  optional :c, :uint32, 3
end


class CompositeMessage
  include Beefcake::Message

  required :encodable, SimpleMessage, 1
  optional :d, :int32,  2
end

class Utf8MessageTest < Test::Unit::TestCase

  def test_simple_message_with_utf8_string
    msg = SimpleMessage.new(:a => 1, :b => "Побочки тоже люди", :c => 1234)
    enc = msg.encode
    dec = SimpleMessage.decode(enc)
    assert_equal "<SimpleMessage a: 1, b: \"Побочки тоже люди\", c: 1234>", dec.inspect
  end

  def test_nested_messages_with_utf8_string
    msg = CompositeMessage.new(:encodable => SimpleMessage.new(:a => 1, :b => "Побочки тоже люди"), :d => 13)
    enc = msg.encode
    p enc
    dec = CompositeMessage.decode(enc)
    assert_equal "<CompositeMessage encodable: <SimpleMessage a: 1, b: \"Побочки тоже люди\">, d: 13>", dec.inspect
  end
end

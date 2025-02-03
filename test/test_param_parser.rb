require "minitest/autorun"
require "jekyll-design-tag-framework/parameter_parser"

ParameterParser = Jekyll::DesignTagFramework::ParameterParser

class ParamParserTest < Minitest::Test
  def test_with_parameters
    jdt_params = ParameterParser.new("test_tag", "param1=\"test\" param2=\"test2\"")
    params = jdt_params.parse_params({})

    assert_equal "test", params["param1"]
    assert_equal "test2", params["param2"]
  end

  def test_with_variables
    jdt_params = ParameterParser.new("test_tag", "param1=\"test\" param2=test2 param3=test.test3")
    params = jdt_params.parse_params({ "test2" => "42", "test.test3" => "43"})

    assert_equal "test", params["param1"]
    assert_equal "42", params["param2"]
    assert_equal "43", params["param3"]
  end

  def test_empty_params
    jdt_params = ParameterParser.new("test_tag", "   ")
    jdt_params.parse_params({})
  end

  def test_failure_params
    assert_raises ArgumentError do
      ParameterParser.new("test_tag", "asdsad")
    end
  end
end

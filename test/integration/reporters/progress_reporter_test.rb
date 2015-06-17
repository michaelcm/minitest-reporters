require_relative "../../test_helper"

module MinitestReportersTest
  class ProgressReporterTest < TestCase
    def test_all_failures_are_displayed
      fixtures_directory = File.expand_path('../../../fixtures', __FILE__)
      test_filename = File.join(fixtures_directory, 'progress_test.rb')
      output = `ruby #{test_filename} 2>&1`
      puts "#{ENV.to_a}"
      assert_match /ERROR(\033\[0m)*\["test_error"/, output, 'Errors should be displayed'
      assert_match /FAIL(\033\[0m)*\["test_failure"/, output, 'Failures should be displayed'
      assert_match /SKIP(\033\[0m)*\["test_skip"/, output, 'Skipped tests should be displayed'
    end
    def test_skipped_tests_are_not_displayed
      fixtures_directory = File.expand_path('../../../fixtures', __FILE__)
      test_filename = File.join(fixtures_directory, 'progress_detailed_skip_test.rb')
      output = `ruby #{test_filename} 2>&1`
      assert_match /ERROR(\033\[0m)*\["test_error"/, output, 'Errors should be displayed'
      assert_match /FAIL(\033\[0m)*\["test_failure"/, output, 'Failures should be displayed'
      refute_match /SKIP(\033\[0m)*\["test_skip"/, output, 'Skipped tests should not be displayed'
    end
  end
end

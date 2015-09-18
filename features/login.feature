Feature: Allow a user to ssh into an image to test internally

  Scenario: Trying to login to an unknown biobox type
    When I run the command:
      """
      biobox login unknown biobox/velvet
      """
    Then the stdout should be empty
    And the exit code should be 1
    And the stderr should equal:
      """
      Unknown biobox type: "unknown".
      Run `biobox --help` for a list of available.

      """

  Scenario: Trying to login to non-existent biobox image
    When I run the command:
      """
      biobox login short_read_assembler biobox/unknown
      """
    Then the stdout should be empty
    And the exit code should be 1
    And the stderr should equal:
      """
      No Docker image available with the name: biobox/unknown
      Did you include the namespace too? E.g. bioboxes/velvet.

      """

  Scenario: Logging into an image and listing file locations
    When I run the interactive command:
      """
      biobox login short_read_assembler bioboxes/velvet
      """
    And I type:
      """
      ls /bbx/*
      """
    Then the stdout should contain:
      """
      output:
      """
    And the stdout should contain:
      """
      input:
      biobox.yaml reads.fq.gz
      """

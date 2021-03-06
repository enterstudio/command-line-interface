Feature: Providing useful errors to a user when they run the tool incorrectly

  Scenario Outline: Trying to run an unknown command
    When I run the command:
      """
      biobox <cmd> short_read_assembler bioboxes/velvet --help
      """
    Then the stdout should be empty
    And the exit code should be 1
    And the stderr should equal:
      """
      Unknown command: "<cmd>".
      Run `biobox --help` for a list of available.

      """

    Examples:
      | cmd     |
      | dummy   |
      | unknown |


  Scenario Outline: Trying to use an unknown biobox type
    When I run the command:
      """
      biobox <command> unknown bioboxes/velvet
      """
    Then the stdout should be empty
    And the exit code should be 1
    And the stderr should equal:
      """
      Unknown biobox type: "unknown".
      Run `biobox --help` for a list of available.

      """

    Examples:
      | command |
      | login   |
      | run     |
      | verify  |

  @internet
  Scenario Outline: Trying to use an unknown biobox image
    When I run the command:
      """
      biobox <command> <type> bioboxes/unknown <args>
      """
    Then the stdout should be empty
    And the stderr should equal:
      """
      No Docker image available with the name: bioboxes/unknown
      Did you include the namespace too? E.g. bioboxes/velvet.

      """
    And the exit code should be 1

    Examples:
      | command | type                 | args                                    |
      | run     | short_read_assembler | --input=reads.fq.gz --output=contigs.fa |
      | login   | short_read_assembler |                                         |
      | verify  | short_read_assembler |                                         |

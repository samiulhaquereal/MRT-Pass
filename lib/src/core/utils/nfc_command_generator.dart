// NfcCommandGenerator class to generate the read command
class NfcCommandGenerator {
  // Generates the read command
  List<int> generateReadCommand(List<int> idm,
      {int serviceCode = 0x220F,
        int numberOfBlocksToRead = 10,
        int startBlockNumber = 0}) {
    // Convert the service code into a byte array (little-endian)
    var serviceCodeList = [
      (serviceCode & 0xFF),
      ((serviceCode >> 8) & 0xFF)
    ];

    // Prepare the block list elements
    var blockListElements = List<int>.generate(
        numberOfBlocksToRead * 2, (index) {
      return index % 2 == 0 ? 0x80 : (startBlockNumber + index ~/ 2);
    });

    // Calculate the total length of the command
    var commandLength = 14 + blockListElements.length;
    var command = List<int>.filled(commandLength, 0);

    var idx = 0;
    // Populate the command array step by step
    command[idx++] = commandLength;
    command[idx++] = 0x06; // Command code

    // Copy the IDM into the command array
    command.setRange(idx, idx + idm.length, idm);
    idx += idm.length;

    command[idx++] = 0x01; // Some fixed byte (e.g., command type)
    command[idx++] = serviceCodeList[0]; // Service code low byte
    command[idx++] = serviceCodeList[1]; // Service code high byte
    command[idx++] = numberOfBlocksToRead; // Number of blocks to read

    // Copy the block list elements into the command array
    command.setRange(idx, idx + blockListElements.length, blockListElements);

    return command;
  }
}
class NfcCommandGenerator {
  List<int> generateReadCommand(List<int> idm,
      {int serviceCode = 0x220F,
        int numberOfBlocksToRead = 10,
        int startBlockNumber = 0}) {
    var serviceCodeList = [
      (serviceCode & 0xFF),
      ((serviceCode >> 8) & 0xFF)
    ];
    var blockListElements = List<int>.generate(
        numberOfBlocksToRead * 2, (index) {
      return index % 2 == 0 ? 0x80 : (startBlockNumber + index ~/ 2);
    });
    var commandLength = 14 + blockListElements.length;
    var command = List<int>.filled(commandLength, 0);
    var idx = 0;
    command[idx++] = commandLength;
    command[idx++] = 0x06;
    command.setRange(idx, idx + idm.length, idm);
    idx += idm.length;
    command[idx++] = 0x01;
    command[idx++] = serviceCodeList[0];
    command[idx++] = serviceCodeList[1];
    command[idx++] = numberOfBlocksToRead;
    command.setRange(idx, idx + blockListElements.length, blockListElements);
    return command;
  }
}
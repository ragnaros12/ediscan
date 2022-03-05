part of 'code_bloc.dart';

abstract class CodeState {
  const CodeState();
}

class CodeInitial extends CodeState {
}

class DataReady extends CodeState {
}

class GetDataState extends CodeState{
  final List<Code> codes;

  const GetDataState(this.codes);
}

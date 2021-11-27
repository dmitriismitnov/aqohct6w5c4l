part of '../blocs.dart';

@freezed
class ${BlocName}State with _$${BlocName}State {
  const ${BlocName}State._();

  const factory ${BlocName}State.initial() = ${BlocName}StateInitial;
  
  const factory ${BlocName}State.pending() = ${BlocName}StatePending;
  
  const factory ${BlocName}State.succeeded() = ${BlocName}StateSucceeded;
  
  const factory ${BlocName}State.failed({
    required String message,
  }) = ${BlocName}StateFailed;

  bool get isInitialState => this is ${BlocName}StateInitial;
  bool get isPendingState => this is ${BlocName}StatePending;
  bool get isSucceededState => this is ${BlocName}StateSucceeded;
  bool get isFailedState => this is ${BlocName}StateFailed;

  ${BlocName}StateInitial? get tryAsInitialState => isInitialState ? asInitialState : null;
  ${BlocName}StatePending? get tryAsPendingState => isPendingState ? asPendingState : null;
  ${BlocName}StateSucceeded? get tryAsSucceededState => isSucceededState ? asSucceededState : null;
  ${BlocName}StateFailed? get tryAsFailedState => isFailedState ? asFailedState : null;

  ${BlocName}StateInitial get asInitialState => this as ${BlocName}StateInitial;
  ${BlocName}StatePending get asPendingState => this as ${BlocName}StatePending;
  ${BlocName}StateSucceeded get asSucceededState => this as ${BlocName}StateSucceeded;
  ${BlocName}StateFailed get asFailedState => this as ${BlocName}StateFailed;

  String get unsafeFailedMessage => maybeFailedMessage!;
  String? get maybeFailedMessage => tryAsFailedState?.message;
}

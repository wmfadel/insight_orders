part of 'localization_cubit.dart';

sealed class LocalizationState extends Equatable {}

final class LocalizationInitial extends LocalizationState {
  @override
  List<Object?> get props => [];
}

final class LocalizationUpdate extends LocalizationState {
  final Locale locale;

  LocalizationUpdate(this.locale);

  @override
  List<Object?> get props => [locale];
}

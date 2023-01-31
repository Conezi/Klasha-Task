import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data_factory/recipes_data_factory.dart';
import '../mocks/repository_mocks/mock_recipes_repository.dart';
import '../mocks/view_model_mocks/mock_user_view_model.dart';

void main() {
/*  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRecipesRepository accountRepository;
  late MockRecipesViewModel userViewModel;
  late AccountCubit accountCubit;

  final validData = SuccessResponse<UserData>.fromMap(RecipesDataFactory.agentData,
      data: UserData.fromMap(RecipesDataFactory.agentData['data']));

  final invalidData = SuccessResponse<UserData>.fromMap(
      RecipesDataFactory.customerData,
      data: UserData.fromMap(RecipesDataFactory.customerData['data']));

  setUp(() {
    accountRepository = MockRecipesRepository();
    userViewModel = MockRecipesViewModel();
    accountCubit =
        AccountCubit(repository: accountRepository, viewModel: userViewModel);
  });

  tearDown(() {
    accountCubit.close();
    userViewModel.dispose();
  });

  group('Test Login Cubit ', () {
    blocTest(
        'emits [AccountProcessing(), AccountLoaded()]'
        ' when request was successful and has a valid user data',
        build: () {
          when(() => accountRepository.loginUser(
              email: any(named: 'email'),
              password: any(named: 'password'))).thenAnswer(
            (_) => Future.value(validData),
          );
          when(() => userViewModel.setUser(validData.data)).thenAnswer(
            (_) => Future.value(),
          );
          return accountCubit;
        },
        act: (AccountCubit cubit) {
          cubit.loginUser(Environment.dev,
              email: 'email', password: 'password');
        },
        expect: () => [AccountProcessing(), AccountLoaded(validData.data)]);

    blocTest(
        'emits [AccountProcessing(), AccountNetworkErr()]'
        ' when request was successful and has a invalid user data',
        build: () {
          when(() => accountRepository.loginUser(
              email: any(named: 'email'),
              password: any(named: 'password'))).thenAnswer(
            (_) => Future.value(invalidData),
          );
          return accountCubit;
        },
        act: (AccountCubit cubit) {
          cubit.loginUser(Environment.dev,
              email: 'email', password: 'password');
        },
        expect: () => [
              AccountProcessing(),
              const AccountNetworkErr(ConstantStrings.loginError)
            ]);

    blocTest(
        'emits [AccountProcessing(), AccountNetworkErr()]'
        ' when error occurred while login in',
        build: () {
          when(() => accountRepository.loginUser(
              email: any(named: 'email'),
              password: any(named: 'password'))).thenThrow(ApiException(null));
          return accountCubit;
        },
        act: (AccountCubit cubit) {
          cubit.loginUser(Environment.dev,
              email: 'email', password: 'password');
        },
        expect: () => [
              AccountProcessing(),
              const AccountNetworkErr(ConstantStrings.defaultNetworkError)
            ]);
  });*/
}

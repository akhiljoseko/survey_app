import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_surveys/core/result.dart';
import 'package:school_surveys/domain/entities/user.dart';

// ------------------ Cubit & State ------------------

class AssignedUserState {
  final List<User> userList;
  final User? selectedUserId;
  final bool isLoading;
  final String? error;

  AssignedUserState({
    required this.userList,
    this.selectedUserId,
    this.isLoading = false,
    this.error,
  });

  AssignedUserState copyWith({
    List<User>? userList,
    User? selectedUserId,
    bool? isLoading,
    String? error,
  }) {
    return AssignedUserState(
      userList: userList ?? this.userList,
      selectedUserId: selectedUserId ?? this.selectedUserId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AssignedUserCubit extends Cubit<AssignedUserState> {
  final Future<Result<List<User>>> Function() fetchUsers;

  AssignedUserCubit({required this.fetchUsers, User? initialSelectedUserId})
    : super(
        AssignedUserState(userList: [], selectedUserId: initialSelectedUserId),
      ) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await fetchUsers();
    switch (result) {
      case Ok<List<User>>():
        emit(
          state.copyWith(
            isLoading: false,
            userList: result.value,
            selectedUserId:
                state.selectedUserId != null &&
                        result.value.any(
                          (u) => u.id == state.selectedUserId?.id,
                        )
                    ? state.selectedUserId
                    : null,
          ),
        );
      case Error<List<User>>():
        emit(state.copyWith(isLoading: false, error: "Failed to load users"));
    }
  }

  void selectUser(User? userId) {
    emit(state.copyWith(selectedUserId: userId));
  }
}

// ------------------ Widget ------------------

class UserDropdownButton extends StatelessWidget {
  final Future<Result<List<User>>> Function() fetchUsers;
  final String label;
  final FormFieldValidator<User>? validator;
  final bool enabled;
  final User? initialSelectedUser;
  final ValueChanged<User?>? onChanged;

  const UserDropdownButton({
    super.key,
    required this.fetchUsers,
    required this.label,
    this.validator,
    this.enabled = true,
    this.initialSelectedUser,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => AssignedUserCubit(
            fetchUsers: fetchUsers,
            initialSelectedUserId: initialSelectedUser,
          ),
      child: BlocBuilder<AssignedUserCubit, AssignedUserState>(
        builder: (context, state) {
          return DropdownButtonFormField<User>(
            value: state.selectedUserId,
            decoration: InputDecoration(
              errorText: state.error,
              labelText: label,
              hintText: "",
            ),
            validator: validator,
            onChanged:
                enabled
                    ? (value) {
                      context.read<AssignedUserCubit>().selectUser(value);
                      if (onChanged != null) onChanged!(value);
                    }
                    : null,

            items: List<DropdownMenuItem<User>>.from(
              state.userList.map(
                (us) => DropdownMenuItem<User>(
                  value: us,
                  child: Text(us.displayName),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

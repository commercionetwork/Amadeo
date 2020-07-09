class DialogWarningsRepository {
  bool webWarningDialogShown;
  bool keysWarningDialogShown;

  DialogWarningsRepository({
    bool webWarningDialogShown,
    bool keysWarningDialogShown,
  })  : webWarningDialogShown = webWarningDialogShown ?? false,
        keysWarningDialogShown = keysWarningDialogShown ?? false;
}

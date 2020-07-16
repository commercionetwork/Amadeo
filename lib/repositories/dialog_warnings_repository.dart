class DialogWarningsRepository {
  bool webWarningDialogShown;
  bool desktopWarningDialogShown;
  bool keysWarningDialogShown;

  DialogWarningsRepository({
    bool webWarningDialogShown,
    bool keysWarningDialogShown,
    bool desktopWarningDialogShown,
  })  : webWarningDialogShown = webWarningDialogShown ?? false,
        keysWarningDialogShown = keysWarningDialogShown ?? false,
        desktopWarningDialogShown = desktopWarningDialogShown ?? false;
}

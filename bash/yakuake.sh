y_set_tab_title(){
  qdbus org.kde.yakuake /yakuake/tabs org.kde.yakuake.setTabTitle "`qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.activeSessionId`" "$1";
}

//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_windows/file_selector_windows.h>
#include <isar_flutter_libs/isar_flutter_libs_plugin.h>
#include <screen_retriever/screen_retriever_plugin.h>
#include <window_manager/window_manager_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  IsarFlutterLibsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("IsarFlutterLibsPlugin"));
  ScreenRetrieverPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ScreenRetrieverPlugin"));
  WindowManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowManagerPlugin"));
}

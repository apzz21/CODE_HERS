//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

<<<<<<< HEAD
#include <audioplayers_windows/audioplayers_windows_plugin.h>
=======
>>>>>>> 81b1ac95a9117d92a77faa06b244c0b3801e2abc
#include <file_selector_windows/file_selector_windows.h>
#include <geolocator_windows/geolocator_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
<<<<<<< HEAD
  AudioplayersWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AudioplayersWindowsPlugin"));
=======
>>>>>>> 81b1ac95a9117d92a77faa06b244c0b3801e2abc
  FileSelectorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileSelectorWindows"));
  GeolocatorWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("GeolocatorWindows"));
}

//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <loadmore_listview/loadmore_listview_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) loadmore_listview_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "LoadmoreListviewPlugin");
  loadmore_listview_plugin_register_with_registrar(loadmore_listview_registrar);
}

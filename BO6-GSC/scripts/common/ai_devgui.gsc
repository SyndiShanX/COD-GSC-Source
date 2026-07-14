/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\ai_devgui.gsc
****************************************/

#using scripts\common\devgui;
#namespace ai_devgui;

function function_e2b40c60922f9148() {
  devgui::function_fc97f67ff432e7de("<dev string:x24>");
  devgui::function_ddef1d43d4e5ef07("<dev string:x30>", "<dev string:x3c>", &function_deccb4f22deadf69);
  devgui::function_ddef1d43d4e5ef07("<dev string:x4b>", "<dev string:x60>", &function_a7d816dfefcd59a3);
  devgui::function_9c2be2438708a992();
}

function private function_deccb4f22deadf69() {
  all_ai = getaispeciesarray("<dev string:x78>", "<dev string:x78>");

  foreach(ai in all_ai) {
    if(isDefined(ai) && isalive(ai)) {
      ai kill();
    }
  }
}

function private function_a7d816dfefcd59a3() {
  ai_enabled = getdvarint(@ "ai_enabled");
  all_ai = getaispeciesarray("<dev string:x78>", "<dev string:x78>");

  if(ai_enabled == 0) {
    setsaveddvar(@ "ai_enabled", 1);

    foreach(ai in all_ai) {
      if(isDefined(ai) && isDefined(ai.animplaybackrateoriginal)) {
        ai.animplaybackratedefault = ai.animplaybackrateoriginal;
        ai.animplaybackrateoriginal = undefined;
        ai restartanim(ai function_aefbdf74acf01f1b());
      }
    }

    return;
  }

  setsaveddvar(@ "ai_enabled", 0);

  foreach(ai in all_ai) {
    if(isDefined(ai)) {
      if(!isDefined(ai.animplaybackrateoriginal)) {
        ai.animplaybackrateoriginal = ai.animplaybackratedefault;
      }

      ai.animplaybackratedefault = 1e-06;
      ai restartanim(ai function_aefbdf74acf01f1b());
    }
  }
}

# /
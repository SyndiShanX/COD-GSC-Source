/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\postfx_shared.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace postfx;

autoexec __init__system__() {
  system::register(#"postfx_bundle", &__init__, undefined, undefined);
}

__init__() {
  callback::on_localplayer_spawned(&localplayer_postfx_bundle_init);
}

localplayer_postfx_bundle_init(localclientnum) {
  if(isDefined(self.postfxbundelsinited)) {
    return;
  }

  self.postfxbundelsinited = 1;
  self.playingpostfxbundle = "";
  self.forcestoppostfxbundle = 0;
  self.exitpostfxbundle = 0;

  self thread postfxbundledebuglisten();
  self thread function_764eb053();
}

postfxbundledebuglisten() {
  self endon(#"death");
  setdvar(#"scr_play_postfx_bundle", "<dev string:x38>");
  setdvar(#"scr_stop_postfx_bundle", "<dev string:x38>");
  setdvar(#"scr_exit_postfx_bundle", "<dev string:x38>");

  while(true) {
    playbundlename = getdvarstring(#"scr_play_postfx_bundle");

    if(playbundlename != "<dev string:x38>") {
      self thread playpostfxbundle(playbundlename);
      setdvar(#"scr_play_postfx_bundle", "<dev string:x38>");
    }

    stopbundlename = getdvarstring(#"scr_stop_postfx_bundle");

    if(stopbundlename != "<dev string:x38>") {
      self thread stoppostfxbundle(stopbundlename);
      setdvar(#"scr_stop_postfx_bundle", "<dev string:x38>");
    }

    var_38ce085 = getdvarstring(#"scr_exit_postfx_bundle");

    if(var_38ce085 != "<dev string:x38>") {
      self thread exitpostfxbundle(var_38ce085);
      setdvar(#"scr_exit_postfx_bundle", "<dev string:x38>");
    }

    wait 0.5;
  }
}

function_764eb053() {
  self endon(#"death");
  var_986c8888 = 0;
  var_4828f60f = 0;
  var_e0f0fb1d = "<dev string:x38>";
  ent = undefined;

  while(true) {
    showmodel = getdvarint(#"hash_56d8c90edb7a97b6", 0);
    showviewmodel = getdvarint(#"hash_65c459b02d95c9c9", 0);
    newspawn = 0;

    if(showmodel != var_986c8888) {
      if(showmodel > 0) {
        if(!isDefined(ent)) {
          newspawn = 1;
          ent = util::spawn_model(self.localclientnum, "<dev string:x3b>");
        }
      } else if(var_986c8888 > 0) {
        if(isDefined(ent)) {
          ent delete();
          ent = undefined;
        }
      }

      var_986c8888 = showmodel;
    }

    if((newspawn || showmodel == 1) && isDefined(ent)) {
      ent.origin = self.origin + (0, 0, 70) + anglesToForward(self.angles) * 250;
    }

    bundlename = getdvarstring(#"cg_playrenderoverridebundle", "<dev string:x38>");

    if(bundlename != var_e0f0fb1d && isDefined(ent)) {
      ent stoprenderoverridebundle(var_e0f0fb1d);

      if(bundlename != "<dev string:x38>") {
        ent playrenderoverridebundle(bundlename);
      }
    }

    if(showviewmodel && (showviewmodel != var_4828f60f || bundlename != var_e0f0fb1d)) {
      self stoprenderoverridebundle(var_e0f0fb1d);

      if(bundlename != "<dev string:x38>") {
        self playrenderoverridebundle(bundlename);
      }
    }

    var_e0f0fb1d = bundlename;
    var_4828f60f = showviewmodel;
    waitframe(1);
  }
}

playpostfxbundle(playbundlename) {
  self thread watchentityshutdown(playbundlename);
  self codeplaypostfxbundle(playbundlename);
}

watchentityshutdown(playbundlename) {
  self notify("6433c543b3eba711" + playbundlename);
  self endon("6433c543b3eba711" + playbundlename);
  localclientnum = self.localclientnum;
  self waittill(#"death", #"finished_playing_postfx_bundle");
  codestoppostfxbundlelocal(localclientnum, playbundlename);
}

stoppostfxbundle(bundlename) {
  self codestoppostfxbundle(bundlename);
}

function_c8b5f318(bundlename, constname, constvalue) {
  self function_116b95e5(bundlename, constname, constvalue);
}

function_556665f2(bundlename) {
  return self function_d2cb869e(bundlename);
}

exitpostfxbundle(bundlename) {
  self function_3f145588(bundlename);
}

setfrontendstreamingoverlay(localclientnum, system, enabled) {
  if(!isDefined(self.overlayclients)) {
    self.overlayclients = [];
  }

  if(!isDefined(self.overlayclients[localclientnum])) {
    self.overlayclients[localclientnum] = [];
  }

  self.overlayclients[localclientnum][system] = enabled;

  foreach(en in self.overlayclients[localclientnum]) {
    if(en) {
      enablefrontendstreamingoverlay(localclientnum, 1);
      return;
    }
  }

  enablefrontendstreamingoverlay(localclientnum, 0);
}
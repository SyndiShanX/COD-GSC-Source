/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7c727635e50af640.csc
***********************************************/

#using script_4e53735256f112ac;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_1fd59e39;

function private autoexec __init__system__() {
  system::register(#"hash_7fd3c8de50685459", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("allplayers", "" + # "hash_59400ab6cbfaec5d", 1, 1, "int", &function_3d1947be, 0, 0);
  callback::on_spawned(&on_spawned);
}

function function_3d1947be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!isDefined(level.var_119220bf)) {
    level.var_119220bf = [];
  }

  if(!isDefined(level.var_119220bf)) {
    level.var_119220bf = [fieldname];
  }

  var_47c85523 = self getentitynumber();

  if(!isDefined(level.var_119220bf[fieldname][var_47c85523])) {
    level.var_119220bf[fieldname][var_47c85523] = spawnStruct();
  }

  if(bwastimejump) {
    self zm_utility::function_88c3a609();

    if(zm_utility::function_f8796df3(fieldname)) {
      self playrenderoverridebundle(#"hash_6ec5fcc31672bb85");

      if(self postfx::function_556665f2(#"hash_5bcfd80691463dec")) {
        self postfx::stoppostfxbundle(#"hash_5bcfd80691463dec");
      }

      self postfx::playpostfxbundle(#"hash_5bcfd80691463dec");

      if(!isDefined(level.var_119220bf[fieldname][var_47c85523].var_6ebc510f) && self function_da43934d()) {
        level.var_119220bf[fieldname][var_47c85523].var_6ebc510f = playfxoncamera(fieldname, #"hash_7fcde6a254a7228", (0, 0, 0), (1, 0, 0), (0, 0, 1));
      }

      self thread function_222efb26(fieldname);
    } else {
      self playrenderoverridebundle(#"hash_733f9eb274c33ff8");

      if(!isDefined(level.var_119220bf[fieldname][var_47c85523].var_afd98b5)) {
        level.var_119220bf[fieldname][var_47c85523].var_afd98b5 = util::playFXOnTag(fieldname, #"hash_803ea6a2550a53a", self, "j_head");
      }

      if(!isDefined(level.var_119220bf[fieldname][var_47c85523].var_895c513a)) {
        level.var_119220bf[fieldname][var_47c85523].var_895c513a = util::playFXOnTag(fieldname, #"hash_ee42b8ead6d79d1", self, "j_spine4");
      }
    }

    if(!isDefined(level.var_119220bf[fieldname][var_47c85523].var_631ff0ad)) {
      self playSound(fieldname, #"hash_6f1e98cba03ff12a", self.origin + (0, 0, 75));
      level.var_119220bf[fieldname][var_47c85523].var_631ff0ad = self playLoopSound(#"hash_493bcaf7ad0973e", undefined, (0, 0, 75));
    }

    return;
  }

  self function_c8e90b89(fieldname);
}

function private function_222efb26(localclientnum) {
  self notify("3087be7f1454ad8e");
  self endon("3087be7f1454ad8e");
  self endon(#"death", #"hash_69b6a912d9991761");

  while(true) {
    var_b1b72524 = self isplayerads();

    if(self function_d2503806(#"hash_6ec5fcc31672bb85") && var_b1b72524) {
      self stoprenderoverridebundle(#"hash_6ec5fcc31672bb85");
      self zm_utility::function_6c91d22b();
    } else if(!self function_d2503806(#"hash_6ec5fcc31672bb85") && !var_b1b72524) {
      self zm_utility::function_88c3a609();
      self playrenderoverridebundle(#"hash_6ec5fcc31672bb85");
    }

    waitframe(1);
  }
}

function on_spawned(localclientnum) {
  self function_c8e90b89(localclientnum);
}

function function_c8e90b89(localclientnum) {
  var_47c85523 = self getentitynumber();
  self notify(#"hash_69b6a912d9991761");

  if(self function_d2503806(#"hash_6ec5fcc31672bb85") && self function_21c0fa55()) {
    self stoprenderoverridebundle(#"hash_6ec5fcc31672bb85");
  }

  if(self function_d2503806(#"hash_733f9eb274c33ff8")) {
    self stoprenderoverridebundle(#"hash_733f9eb274c33ff8");
  }

  self zm_utility::function_6c91d22b();

  if(self postfx::function_556665f2(#"hash_5bcfd80691463dec") && self function_21c0fa55()) {
    self postfx::exitpostfxbundle(#"hash_5bcfd80691463dec");
  }

  if(isDefined(level.var_119220bf[localclientnum][var_47c85523].var_6ebc510f)) {
    stopfx(localclientnum, level.var_119220bf[localclientnum][var_47c85523].var_6ebc510f);
    level.var_119220bf[localclientnum][var_47c85523].var_6ebc510f = undefined;
  }

  if(isDefined(level.var_119220bf[localclientnum][var_47c85523].var_afd98b5)) {
    stopfx(localclientnum, level.var_119220bf[localclientnum][var_47c85523].var_afd98b5);
    level.var_119220bf[localclientnum][var_47c85523].var_afd98b5 = undefined;
  }

  if(isDefined(level.var_119220bf[localclientnum][var_47c85523].var_895c513a)) {
    stopfx(localclientnum, level.var_119220bf[localclientnum][var_47c85523].var_895c513a);
    level.var_119220bf[localclientnum][var_47c85523].var_895c513a = undefined;
  }

  if(isDefined(level.var_119220bf[localclientnum][var_47c85523].var_631ff0ad)) {
    self playSound(localclientnum, #"hash_5a6fa72d8d9f935f", self.origin + (0, 0, 75));
    self stoploopsound(level.var_119220bf[localclientnum][var_47c85523].var_631ff0ad);
    level.var_119220bf[localclientnum][var_47c85523].var_631ff0ad = undefined;
  }
}
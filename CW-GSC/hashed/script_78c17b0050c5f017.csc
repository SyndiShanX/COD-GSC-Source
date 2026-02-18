/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_78c17b0050c5f017.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace world_event_horde_hunt;

function private autoexec __init__system__() {
  system::register(#"hash_1e60252f388011fb", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_7029ea8551fb906f")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  clientfield::register("actor", "sr_horde_hunt_fx", 1, 1, "int", &sr_horde_hunt_fx, 0, 0);
  clientfield::register("world", "sr_horde_hunt_decals", 1, 2, "int", &sr_horde_hunt_decals, 0, 0);
}

function sr_horde_hunt_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 && isDefined(self)) {
    self util::waittill_dobj(fieldname);

    if(!isDefined(self)) {
      return;
    }

    function_239993de(fieldname, #"hash_6258a90cdd74e1e0", self, "tag_origin");

    if(self.var_44ac8cdd === 1 && isDefined(self.var_a0bf769b)) {
      stopfx(fieldname, self.var_a0bf769b);
      self.var_a0bf769b = util::playFXOnTag(fieldname, #"zm_ai/fx9_mech_head_light", self, "tag_headlamp_FX");
      fxclientutils::stopfxbundle(fieldname, self, self.fxdef);
      fxclientutils::playfxbundle(fieldname, self, self.fxdef);
    }
  }
}

function sr_horde_hunt_decals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    str_targetname = "hordehunt_corpses_1";
  } else if(bwastimejump == 2) {
    str_targetname = "hordehunt_corpses_2";
  } else {
    str_targetname = "hordehunt_corpses_3";
  }

  a_n_decals = findvolumedecalindexarray(str_targetname);

  foreach(n_decal in a_n_decals) {
    unhidevolumedecal(n_decal);
  }
}
/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\cp\ac130.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#using scripts\killstreaks\ac130_shared;
#namespace ac130;

function private autoexec __init__system__() {
  system::register(#"ac130", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
  clientfield::register("toplayer", "inAC130", 1, 1, "int", &function_555656fe, 0, 1);
}

function private function_35aed314(localplayerteam, otherteam) {
  if(!isDefined(localplayerteam) || !isDefined(otherteam)) {
    return false;
  }

  if(otherteam == # "neutral") {
    return false;
  }

  return localplayerteam != otherteam;
}

function private function_7b91bbdd(localclientnum) {
  vehicle = self;
  vehicle endon(#"death", #"hash_67080015640c605d");
  vehicle waittill(#"vehicle_death_fx");
  vehicle renderoverridebundle::function_f4eab437(localclientnum, 0, #"hash_2c6fce4151016478");
}

function private function_7415e9d3(localclientnum, var_634b8583, entitytype, var_e186bbd8) {
  entarray = getentarraybytype(localclientnum, entitytype);

  foreach(ent in entarray) {
    if(function_35aed314(var_634b8583, ent.team)) {
      ent renderoverridebundle::function_f4eab437(localclientnum, var_e186bbd8, #"hash_2c6fce4151016478");

      if(entitytype == 12) {
        ent notify(#"hash_67080015640c605d");

        if(var_e186bbd8) {
          ent thread function_7b91bbdd(localclientnum);
        }
      }
    }
  }
}

function private function_e6d3dbbc(localclientnum) {
  entity = self;
  localplayer = function_5c10bd79(localclientnum);

  if(function_35aed314(localplayer.team, entity.team)) {
    entity renderoverridebundle::function_f4eab437(localclientnum, 1, #"hash_2c6fce4151016478");

    if(entity.type == "vehicle") {
      entity thread function_7b91bbdd(localclientnum);
    }
  }
}

function private function_555656fe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  bundle = getscriptbundle("killstreak_ac130" + "_cp");
  postfxbundle = bundle.("ksVehiclePostEffectBun");

  if(!isDefined(postfxbundle)) {
    return;
  }

  self util::waittill_dobj(binitialsnap);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump && self postfx::function_556665f2(postfxbundle)) {
    self codestoppostfxbundle(postfxbundle);
  }

  if(fieldname) {
    if(self postfx::function_556665f2(postfxbundle) == 0) {
      self codeplaypostfxbundle(postfxbundle);
      function_7415e9d3(binitialsnap, self.team, 15, 1);
      callback::function_675f0963(&function_e6d3dbbc);
      function_7415e9d3(binitialsnap, self.team, 12, 1);
      callback::on_vehicle_spawned(&function_e6d3dbbc);
    }

    return;
  }

  if(self postfx::function_556665f2(postfxbundle)) {
    self codestoppostfxbundle(postfxbundle);
    function_7415e9d3(binitialsnap, self.team, 15, 0);
    callback::function_ce9bb4ec(&function_e6d3dbbc);
    function_7415e9d3(binitialsnap, self.team, 12, 0);
    callback::remove_on_vehicle_spawned(&function_e6d3dbbc);
  }
}
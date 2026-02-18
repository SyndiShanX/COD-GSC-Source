/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\clean.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace clean;

function event_handler[gametype_init] main(eventstruct) {
  clientfield::register_clientuimodel("hudItems.cleanCarryCount", #"hud_items", #"cleancarrycount", 14000, 4, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.cleanCarryFull", #"hud_items", #"cleancarryfull", 14000, 1, "int", undefined, 0, 0);
  clientfield::register("scriptmover", "taco_flag", 14000, 2, "int", &function_11abf5b2, 0, 0);
  clientfield::register("allplayers", "taco_carry", 14000, 1, "int", &function_aa7bb941, 0, 0);
  clientfield::register("scriptmover", "taco_waypoint", 14000, 1, "int", &function_a4a5d612, 0, 0);
  level.var_aaaae0b = # "hash_206afab0af20880d";
  level.var_5844252c = # "hash_672b6ef826294e77";
  level.var_ce64ea3e = # "clean_taco";

  if(is_true(getgametypesetting(#"hash_5cc4c3042b7d4935"))) {
    level.var_aaaae0b = # "hash_464eae7df8ee284a";
    level.var_5844252c = # "hash_2b379a7d7b261710";
    level.var_ce64ea3e = # "hash_3a64e972390f43aa";
    setsoundcontext("ltm", "paddy");
    function_52ee8599();
  }

  callback::on_localclient_connect(&on_localclient_connect);
}

function function_52ee8599() {
  function_3385d776(#"ui/fx8_fracture_deposit_point_end_ire");
  forcestreamxmodel(#"p9_pot_of_gold_pristine");
}

function private on_localclient_connect(localclientnum) {
  function_d91ca1f1(localclientnum);
}

function function_11abf5b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"stopbounce");

  if(isDefined(self.var_47b256ef)) {
    self.var_47b256ef unlink();
    self.var_47b256ef.origin = self.origin;
  }

  self function_81431153(fieldname);

  if(bwastimejump != 0) {
    if(!isDefined(self.var_47b256ef)) {
      self.var_47b256ef = spawn(fieldname, self.origin, "script_model");
      self.var_47b256ef setModel(#"tag_origin");
      self thread function_bcb88fb7(fieldname);
    }

    self.var_5844252c = util::playFXOnTag(fieldname, level.var_5844252c, self.var_47b256ef, "tag_origin");
    self function_1f0c7136(5);
    self function_dfbd048b(25);
    setfxteam(fieldname, self.var_5844252c, self.team);
  }

  if(bwastimejump == 1) {
    self.var_47b256ef linkto(self);
    return;
  }

  if(bwastimejump == 2) {
    self thread function_d1834e16(fieldname);
  }
}

function function_bcb88fb7(localclientnum) {
  self waittill(#"death");
  self function_81431153(localclientnum);
  self.var_47b256ef delete();
  self.var_47b256ef = undefined;
  objid = function_53576950(localclientnum, self getentitynumber());

  if(isDefined(objid)) {
    objective_setstate(localclientnum, objid, "invisible");
  }
}

function function_81431153(localclientnum) {
  if(isDefined(self.var_5844252c)) {
    killfx(localclientnum, self.var_5844252c);
    self.var_5844252c = undefined;
  }
}

function function_d1834e16(localclientnum) {
  self endon(#"stopbounce");
  self endon(#"death");
  toppos = self.origin + (0, 0, 12);
  bottompos = self.origin;

  while(true) {
    self.var_47b256ef moveto(toppos, 0.5, 0, 0);
    self.var_47b256ef waittill(#"movedone");
    self.var_47b256ef moveto(bottompos, 0.5, 0, 0);
    self.var_47b256ef waittill(#"movedone");
  }
}

function function_aa7bb941(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_cd6915b7(fieldname);

  if(bwastimejump && function_5c10bd79(fieldname) != self) {
    self util::waittill_dobj(fieldname);

    if(!isDefined(self)) {
      return;
    }

    self.var_aaaae0b = util::playFXOnTag(fieldname, level.var_aaaae0b, self, "j_neck");
    setfxteam(fieldname, self.var_aaaae0b, self.team);
  }
}

function function_5cf5b566(localclientnum) {
  self waittill(#"death");
  self function_cd6915b7(localclientnum);
}

function function_cd6915b7(localclientnum) {
  if(isDefined(self.var_aaaae0b)) {
    killfx(localclientnum, self.var_aaaae0b);
    self.var_aaaae0b = undefined;
  }
}

function function_d91ca1f1(localclientnum) {
  level.var_67485c05[localclientnum] = [];

  for(i = 0; i < 26; i++) {
    level.var_ccb8d7fb[localclientnum][i] = spawnStruct();
    objid = util::getnextobjid(localclientnum);
    level.var_ccb8d7fb[localclientnum][i].id = objid;
    level.var_ccb8d7fb[localclientnum][i].tacoentnum = undefined;
    objective_add(localclientnum, objid, "invisible", level.var_ce64ea3e);
  }
}

function function_5d02c098(localclientnum, tacoentnum) {
  for(i = 0; i < 26; i++) {
    if(!isDefined(level.var_ccb8d7fb[localclientnum][i].tacoentnum)) {
      level.var_ccb8d7fb[localclientnum][i].tacoentnum = tacoentnum;
      return level.var_ccb8d7fb[localclientnum][i].id;
    }
  }

  return undefined;
}

function function_53576950(localclientnum, tacoentnum) {
  for(i = 0; i < 26; i++) {
    if(level.var_ccb8d7fb[localclientnum][i].tacoentnum === tacoentnum) {
      level.var_ccb8d7fb[localclientnum][i].tacoentnum = undefined;
      return level.var_ccb8d7fb[localclientnum][i].id;
    }
  }

  return undefined;
}

function function_a4a5d612(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(function_1cbf351b(fieldname)) {
    return;
  }

  if(bwastimejump) {
    objid = function_5d02c098(fieldname, self getentitynumber());

    if(isDefined(objid)) {
      objective_setstate(fieldname, objid, "active");
      objective_setposition(fieldname, objid, self.origin);
      objective_setteam(fieldname, objid, self.team);
    }

    return;
  }

  objid = function_53576950(fieldname, self getentitynumber());

  if(isDefined(objid)) {
    objective_setstate(fieldname, objid, "invisible");
  }
}
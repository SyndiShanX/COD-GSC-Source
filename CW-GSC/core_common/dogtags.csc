/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\dogtags.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace dogtags;

function init() {
  clientfield::register("scriptmover", "dogtag_flag", 1, 2, "int", &function_319c73b1, 0, 0);
  clientfield::register("scriptmover", "dogtag_clientnum", 20000, 5, "int", &function_eb14e659, 0, 0);
  level.var_70e5d775 = getgametypesetting(#"hash_45b6991b1456a440");
  level.var_1305770 = [];
}

function function_3e0d8ba2() {
  if(isDefined(level.var_ba243d66)) {
    return level.var_ba243d66;
  }

  if(level.var_70e5d775 === 1) {
    var_c2ad857a = [#"hash_214a2287c621274a", #"hash_214a2187c6212597", #"hash_214a2087c62123e4", #"hash_214a1f87c6212231"];
    return var_c2ad857a[randomint(var_c2ad857a.size)];
  }
}

function function_319c73b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"stopbounce");

  if(isDefined(self.var_47b256ef)) {
    self.var_47b256ef unlink();
    self.var_47b256ef.origin = self.origin;
  }

  if(bwastimejump == 0) {
    self function_81431153(fieldname);
    self delete_objective(fieldname);
    return;
  }

  if(!isDefined(self.objectiveid) && util::get_game_type() !== # "spy") {
    objectivename = isDefined(level.var_febab1ea) ? level.var_febab1ea : # "conf_dogtags";
    self.objectiveid = util::getnextobjid(fieldname);
    objective_add(fieldname, self.objectiveid, "active", objectivename, self.origin, self.team);
    objective_onentity(fieldname, self.objectiveid, self, 1, 1, 0);

    if(level.var_70e5d775 === 1) {
      objective_setgamemodeflags(fieldname, self.objectiveid, 1);
    }
  }

  if(!isDefined(self.var_47b256ef)) {
    self.var_47b256ef = spawn(fieldname, self.origin, "script_model");
    self.var_47b256ef.angles = (0, 0, 0);
    self.var_47b256ef setModel(#"tag_origin");
    self thread function_bcb88fb7(fieldname);
  }

  if(!isDefined(self.var_c7d6b0c1) || !isfxplaying(fieldname, self.var_c7d6b0c1)) {
    fxtoplay = function_3e0d8ba2();

    if(!isDefined(fxtoplay)) {
      characterindex = isDefined(self function_ef9de5ae()) ? self function_ef9de5ae() : 0;
      fxtoplay = isDefined(getcharacterfields(characterindex, currentsessionmode()).var_c7d6b0c1) ? getcharacterfields(characterindex, currentsessionmode()).var_c7d6b0c1 : # "hash_30f231c126644dc2";
    }

    self.var_c7d6b0c1 = util::playFXOnTag(fieldname, fxtoplay, self.var_47b256ef, "tag_origin");
    setfxteam(fieldname, self.var_c7d6b0c1, self.team);
  }

  if(bwastimejump == 1) {
    self.var_47b256ef.origin = self.origin;
    self.var_47b256ef linkto(self);
    return;
  }

  if(bwastimejump == 2 || bwastimejump == 3) {
    self thread function_2eee13af();
  }
}

function function_81431153(localclientnum) {
  if(isDefined(self.var_c7d6b0c1)) {
    killfx(localclientnum, self.var_c7d6b0c1);
    self.var_c7d6b0c1 = undefined;
  }
}

function delete_objective(localclientnum) {
  if(isDefined(self.objectiveid)) {
    objective_delete(localclientnum, self.objectiveid);
    util::releaseobjid(localclientnum, self.objectiveid);
    self.objectiveid = undefined;
  }
}

function function_bcb88fb7(localclientnum) {
  self waittill(#"death");
  self function_81431153(localclientnum);
  self delete_objective(localclientnum);

  if(isDefined(self.var_47b256ef)) {
    self.var_47b256ef delete();
    self.var_47b256ef = undefined;
  }
}

function function_2eee13af() {
  self endon(#"stopbounce");
  self endon(#"death");

  while(true) {
    toppos = self.origin + (0, 0, 12);
    self.var_47b256ef moveto(toppos, 0.5, 0, 0);
    self.var_47b256ef waittill(#"movedone");

    if(isDefined(self.clientnum) && self.clientnum > -1) {
      level.var_1305770[self.clientnum] = self.var_47b256ef.origin;
    }

    bottompos = self.origin;
    self.var_47b256ef moveto(bottompos, 0.5, 0, 0);
    self.var_47b256ef waittill(#"movedone");

    if(isDefined(self.clientnum) && self.clientnum > -1) {
      level.var_1305770[self.clientnum] = self.var_47b256ef.origin;
    }
  }
}

function private function_ef9de5ae() {
  return self function_9682ea07();
}

function function_eb14e659(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  clientnum = bwastimejump - 1;

  if(clientnum > -1) {
    level.var_1305770[clientnum] = self.origin;
    self.clientnum = clientnum;
  }
}
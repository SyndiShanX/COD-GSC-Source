/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\animmode.gsc
***********************************************/

function main() {
  self endon("death");
  self endon("stop_animmode");
  self notify("killanimscript");
  self._tag_entity endon(self._anime);

  if(isDefined(self._custom_anim_thread)) {
    self thread[[self._custom_anim_thread]]();
    self._custom_anim_thread = undefined;
  }

  var0 = isDefined(self._custom_anim_loop) && self._custom_anim_loop;

  if(var0) {
    self endon("stop_loop");
    self._custom_anim_loop = undefined;
  } else {
    thread notify_on_end(self._anime);
  }

  var1 = self._anime;
  self._anime = undefined;
  var2 = 0;

  if(var0) {
    var2 = level.scr_anim[self._animname][var1].size;
    var3 = level.scr_anim[self._animname][var1][randomint(var2)];
  } else {
    var3 = level.scr_anim[self._animname][var2];
  }

  var4 = getstartorigin(self._tag_entity.origin, self._tag_entity.angles, var3);
  var5 = getstartangles(self._tag_entity.origin, self._tag_entity.angles, var3);
  var6 = self getdroptofloorposition(var4);

  if(isDefined(var6)) {
    var4 = var6;
  }

  if(!isDefined(self.noteleport)) {
    self teleport(var4, var5);
  }

  self.pushable = 0;
  var7 = 0.3;
  var8 = 0.2;

  if(isDefined(self.anim_blend_time_override)) {
    var7 = self.anim_blend_time_override;
    var8 = self.anim_blend_time_override;
  }

  self animmode(self._animmode);
  self clearanim(scripts\asm\asm::asm_getroot(), 0.3);
  var9 = scripts\asm\asm::asm_getfacialknob();

  if(isDefined(var9)) {
    self setanim(var9, 1, 0.3, 1);
  }

  self orientmode("face angle", var5[1]);
  self animmode("zonly_physics", 1);
  var10 = "custom_animmode";
  self setflaggedanimrestart(var10, var3, 1, var8, 1);
  self._tag_entity thread scripts\common\notetrack::start_notetrack_wait(self, var10, var2, self._animname, var3);
  self._tag_entity thread scripts\sp\anim::animscriptdonotetracksthread(self, var10, var2);
  var11 = self._tag_entity;
  self._tag_entity = undefined;
  self._animmode = undefined;
  self endon("killanimscript");
  var12 = "end";

  if(!var1) {
    if(animhasnotetrack(var3, "finish")) {
      var12 = "finish";
    } else if(animhasnotetrack(var3, "stop anim")) {
      var12 = "stop anim";
    }
  }

  for(;;) {
    self waittillmatch(var10, var12);

    if(var1) {
      var3 = level.scr_anim[self._animname][var2][randomint(var3)];
      self setflaggedanimknoblimitedrestart(var10, var3, 1, 0.2, 1);

      if(isDefined(var11)) {
        var11 thread scripts\common\notetrack::start_notetrack_wait(self, var10, var2, self._animname, var3);
        var11 thread scripts\sp\anim::animscriptdonotetracksthread(self, var10, var2);
      }

      continue;
    }

    break;
  }

  if(var12 != "end") {
    self orientmode("face motion");
  }

  self notify("finished_custom_animmode" + var2);
}

function notify_on_end(var0) {
  self endon("death");
  self endon("finished_custom_animmode" + var0);
  self waittill("killanimscript");
  self notify("finished_custom_animmode" + var0);
}
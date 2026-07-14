/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\animmode.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\common\notetrack;
#using scripts\sp\anim;
#namespace animmode;

function main() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xc3\xeeI\xa0;?\xac\x81\x8e?|\xe9\xe4");
  self notify("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self._tag_entity endon(self._anime);

  if(isDefined(self._custom_anim_thread)) {
    self thread[[self._custom_anim_thread]]();
    self._custom_anim_thread = undefined;
  }

  loop = isDefined(self._custom_anim_loop) && self._custom_anim_loop;

  if(loop) {
    self endon("b\xf6+H\xa9\xcc\x10\x940");
    self._custom_anim_loop = undefined;
  } else {
    thread notify_on_end(self._anime);
  }

  anime = self._anime;
  self._anime = undefined;
  arraysize = 0;

  if(loop) {
    arraysize = level.scr_anim[self._animname][anime].size;
    animationname = level.scr_anim[self._animname][anime][randomint(arraysize)];
  } else {
    animationname = level.scr_anim[self._animname][anime];
  }

  origin = getstartorigin(self._tag_entity.origin, self._tag_entity.angles, animationname);
  angles = getstartangles(self._tag_entity.origin, self._tag_entity.angles, animationname);
  neworigin = self getdroptofloorposition(origin);

  if(isDefined(neworigin)) {
    origin = neworigin;
  } else {
    println("<dev string:x24>" + self getentitynumber() + "<dev string:x5d>");
  }

  if(!isDefined(self.noteleport)) {
    self teleport(origin, angles);
  }

  self.pushable = 0;
  clear_time = 0.3;
  blend_time = 0.2;

  if(isDefined(self.anim_blend_time_override)) {
    clear_time = self.anim_blend_time_override;
    blend_time = self.anim_blend_time_override;
  }

  self animmode(self._animmode);
  self clearanim(asm::asm_getroot(), 0.3);
  facialknob = asm::asm_getfacialknob();

  if(isDefined(facialknob)) {
    self setanim(facialknob, 1, 0.3, 1);
  }

  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", angles[1]);
  self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa", 1);
  anim_string = "{\x94#!\x83\xc8[T\xb7|x\x82O\x9f\x1c";
  self setflaggedanimrestart(anim_string, animationname, 1, blend_time, 1);
  self._tag_entity thread notetrack::start_notetrack_wait(self, anim_string, anime, self._animname, animationname);
  self._tag_entity thread anim_sp::animscriptdonotetracksthread(self, anim_string, anime);
  tag_entity = self._tag_entity;
  self._tag_entity = undefined;
  self._animmode = undefined;
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  endmarker = "8\xdb\x90";

  if(!loop) {
    if(animhasnotetrack(animationname, "\xd7\xca\xae\xca\xff\xdb")) {
      endmarker = "\xd7\xca\xae\xca\xff\xdb";
    } else if(animhasnotetrack(animationname, "7t\xf6\a\x80anik")) {
      endmarker = "7t\xf6\a\x80anik";
    }
  }

  while(true) {
    self waittillmatch(anim_string, endmarker);

    if(loop) {
      animationname = level.scr_anim[self._animname][anime][randomint(arraysize)];
      self setflaggedanimknoblimitedrestart(anim_string, animationname, 1, 0.2, 1);

      if(isDefined(tag_entity)) {
        tag_entity thread notetrack::start_notetrack_wait(self, anim_string, anime, self._animname, animationname);
        tag_entity thread anim_sp::animscriptdonotetracksthread(self, anim_string, anime);
      }

      continue;
    }

    break;
  }

  if(endmarker != "8\xdb\x90") {
    self orientmode("\xa1\xd7\x97\xd7\xf4h\xe0%\xbe \xa1");
  }

  self notify("\xd7\xca\xae\xca\xff\xdb\xf1<\x8f1\xf97\xccqI\xb5fR\xe5%\xf9\xbdY\xe4" + anime);
}

function notify_on_end(msg) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd7\xca\xae\xca\xff\xdb\xf1<\x8f1\xf97\xccqI\xb5fR\xe5%\xf9\xbdY\xe4" + msg);
  self waittill("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self notify("\xd7\xca\xae\xca\xff\xdb\xf1<\x8f1\xf97\xccqI\xb5fR\xe5%\xf9\xbdY\xe4" + msg);
}
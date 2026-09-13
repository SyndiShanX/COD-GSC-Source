/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\smartobjects\hunt_point.gsc
***********************************************/

main() {
  scripts\smartobjects\utility::add_smartobject_type("hunt_point", ::getinfo, ::canuse);
}

canuse(object) {
  return 1;
}

getinfo() {
  info = scripts\smartobjects\utility::createsmartobjectinfo();
  info.fnonuse = ::onuse;
  info._id_D0FC6475ED819558 = 1;
  info.radiussqrd = 3600;
  info.nextusetime = 0;
  info scripts\smartobjects\utility::addsmartobjectanim("loop");
  return info;
}

onuse(object) {
  _id_E8003C5231BAEA93 = self._blackboard._id_3DBE624A18D61F13;
  _id_B205CC0302DA1270 = _func_BC5DF124338CEFEA(self);
  _id_2924E404150FF758 = _id_B205CC0302DA1270 scripts\stealth\group::_id_75087B386454D072(self);
  _id_CC2828DA32453F24 = _id_2924E404150FF758.guys[0];

  if(self == _id_CC2828DA32453F24)
    _id_CC2828DA32453F24 = _id_2924E404150FF758.guys[1];

  _id_B45B78DF70B9FD3A = _id_CC2828DA32453F24._id_7B492275EF047BE2;

  if(self == _id_2924E404150FF758.leader) {
    _id_71F2A25A69F9C80F = randomintrange(1200, 2800);
    self._id_9A04C6CFE15E92A7 = self.origin;
    self._id_587D8840DEA10869 = 1;
    self._id_4B1FA39975A3FD58 = _id_71F2A25A69F9C80F;
    scripts\asm\gesture::ai_request_gesture("military_point", _id_E8003C5231BAEA93, 1000, "first_hunt_gesture");
    self waittill("first_hunt_gesture");

    if(!isDefined(_id_B45B78DF70B9FD3A))
      scripts\asm\gesture::ai_request_gesture("talk", undefined, 1000, "hunt_gesture");
    else {
      _id_CC2828DA32453F24 scripts\engine\utility::delaycall(0.5, ::glanceatpos, _id_B45B78DF70B9FD3A, 300);
      scripts\asm\gesture::ai_request_gesture("military_point", _id_B45B78DF70B9FD3A, 1000, "hunt_gesture");
    }
  } else
    scripts\asm\gesture::ai_request_gesture("yes", undefined, 1000, "hunt_gesture");

  thread _id_EF5A2FD990A632B2("hunt_gesture");
  _id_35DE402EFC5ACFB3::_id_E23B0906B02CD179("coordinate", 20);
}

_id_EF5A2FD990A632B2(flag) {
  self endon("death");
  self endon("smartobject_logic_finished");
  self setlookatentity();
  childthread _id_522562E28309AFAA(10);

  for(;;) {
    self waittill(flag, status);

    if(status == "gesture_finish" || status == "gesture_cancel") {
      break;
    }
  }

  scripts\asm\asm::asm_fireevent(self.asmname, "smartobject_finished");
}

_id_522562E28309AFAA(t) {
  wait(t);
  scripts\asm\asm::asm_fireevent(self.asmname, "smartobject_finished");
}
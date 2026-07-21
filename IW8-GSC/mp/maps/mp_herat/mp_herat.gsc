/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_herat\mp_herat.gsc
***********************************************/

main() {
  _encstr_A1192FE61B394B071D37E5AD0EF2DA2C3837BCB51CBEA1B293B0A3CBDAC1D7435927C247F583E4CA362CC686AC17EC6E6C::main();
  _encstr_A5F82E6E1B9C4B0EE86E5EAD0ECBAD85839B79DA83BED02BE458D1799DB29BE5D6E07D0D9539B03A7DB093E8B876CD8D::main();
  _encstr_991A29AB669B77D221584E6228FFCD0F73D64F3D07C6BB5F15D0835EF89989E3893E89BC084983B5D768FA::main();
  _encstr_B6122FE6867B8B5B24873A50F307B0D3032A7061DA4171210AE7E84AAF700E19FA12DF75F9CA3B29C8AB18589FF6416762::main();
  scripts\mp\load::main();
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_8D0A156CBDB50E2C37E6AFB60BC1EBB683F51A569CB03A", "_encstr_9BBE1F0BB748B6F7CEF3D2AB7E2E17ED40139383BF787EFBE0C87B61A0752BA6B8");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  var_0 = getEnt("_encstr_AD250E2A0AFC8FE53FCB32E028DF9752", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 connectpaths();
  }

  thread scripts\mp\animation_suite::animationsuite();
  level thread spawnstaticvan();
}

spawnstaticvan() {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B")) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")) {
    return;
  }
  if(!scripts\mp\flags::gameflag("_encstr_B27F0F4BB9CC96B1AFDD2D8D1BAF39579B")) {
    foreach(var_1 in [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_A6700FD43F23DF7134E3B108835608C13B")]]()) {
      if(var_1.script_noteworthy != "_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2") {
        continue;
      }
      if(var_1.name != "_encstr_BDBB0616C6C186C2") {
        continue;
      }
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_91260B40A2EC2B91B36DA82E47"] = (-2957, -720.5, 87.5);
      game["_encstr_9B8F06A38D72C380"]["_encstr_9AEF060C8BF8274F"]["_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2"]["_encstr_BDBB0616C6C186C2"]["_encstr_AF260B886A249329FB35F7680F"] = (0, 180, 0);
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9B8F06A38D72C380", "_encstr_928513BB833F4F0D196BDAC36B58D34FD07B6102E8")]]("_encstr_9AB612B4E6CCA5B1BEB32CDCFA1A16C6AD372BF2", "_encstr_BDBB0616C6C186C2");
      break;
    }
  }
}
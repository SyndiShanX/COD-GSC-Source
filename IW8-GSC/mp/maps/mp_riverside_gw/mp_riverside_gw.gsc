/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_riverside_gw\mp_riverside_gw.gsc
*******************************************************/

main() {
  _encstr_A2B63D6E6C93A51C479BBC6B385E6BB0C1DC79DA38F5E45AB3599C9BA52359FAECBB5E5B38F5E42D3B2B276ED24659EBCE77EB0E9C95B1B08D34AC8B76E6D8::main();
  _encstr_8D133C208A2213CB1BA34069984E50CB0A134A2853B19DA07BDDF65E698B99EFB7FBD2F0BA956FF8BBFFFE5B6ED7237F9CB208A9F26B57319BFCA84443E7::main();
  _encstr_A13337CE2E8BC3FBBB0396F07308BD82A7AE1E3AA0D7A034C63360176F1A554F01EFF8ED28C88BB3B36D15DAF7B8BD27978FA75F1E981762BA::main();
  _encstr_A56D3DCFA70B9BB04CE2A0E04A4F6BC7835FFF6B0321DEB0667F733B34EC8810AA2747E39B89A6889E577B33DCD4F0A842BF2F1957526328A96DC1A047AB08::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_12B18();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 19);

    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_86B61CA91DA5487FE3175F3377FBA87850F97360C315102E3A53134F9753");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
}
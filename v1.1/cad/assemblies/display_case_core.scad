// ============================================================================
// Display-case core geometry and assembly coordinates
//
// Transitional project core for geometry that has not yet been split into
// independent components. This file replaces the former legacy directory.
// ============================================================================

// ============================================================================
// HUB75 KAST — HOUTEN FRAME 15 MM — NORMAAL OF MET POCKETHOLES
// Met eiken voorlijst, plexiglasplaat 840 x 360 mm en uitstekende dakplaat.
// Elektronica, HUB75-panelen, bekabeling, DIN-rail en aluminium subframe
use <../components/aluminium_frame.scad>
use <../components/clamps.scad>
use <../components/rear_panel.scad>
// blijven weggelaten.
//
// Standaardweergave:
// - de achterplaat is niet gemonteerd;
// - de voorplaat ligt horizontaal en dient als grond-/montageplaat;
// - het houten frame staat op de voorplaat;
// - de hoekhandgreep is aanwezig;
// - een eiken lijst ligt vóór het frame;
// - het plexiglas ligt achter de eiken lijst met 7 mm overlap rondom.
//
// De dragende framedelen zijn uitgevoerd in 15 mm plaatmateriaal.
// De standaardvariant blijft volledig zonder montagegaten; de pocket-holevariant toont gaten en 16 mm schroeven.
// De eiken lijst is gebaseerd op schaaflat 19 x 25 mm.
// De eiken zijprofielen en bovenregel gebruiken hetzelfde vijfpuntsprofiel als de onderlat;
// de bovenregel heeft een eenvoudig zichtbaar profiel met een rechte 5 mm tong in de dakplaat.
// Onder de onderste plank staan vier houten voetjes van 10 mm hoog en 15 mm breed.
// ============================================================================
use <../components/roundwood_carry_frame.scad>

view_mode = "compleet"; // [compleet, compleet_met_pocketholes_en_schroeven, compleet_gemonteerd, exploded, hout_exploded, voorzijde_met_lijst, eiken_lijst, plexiglas, epdm, stelplaatjes, houten_voetjes, houten_voetje, hout_voorplaat, hout_achterplaat, hout_zijwand_links, hout_zijwand_rechts, hout_bovenkap, hout_tussenbodem, hout_onderbodem, hout_schot_links, hout_schot_rechts, print_kunststof_inzet_links, print_kunststof_inzet_rechts, print_hoekbeugel_links_voor, print_hoekbeugel_links_achter, print_hoekbeugel_rechts_voor, print_hoekbeugel_rechts_achter, print_hoekbeugels_set, rubberen_voet, rubberen_voeten, kunststof_middenvoetjes, compleet_zonder_aluminium, aluminium_frame, led_panelen, aluminium_frame_met_led_panelen, compleet_voorplaat, compleet_grondplaat, klemmen_onder, klemmen_boven, klemmen_beide, glaslat_beschermprofiel_links, glaslat_beschermprofiel_rechts]

montage_met_pocketholes = view_mode == "compleet_met_pocketholes_en_schroeven";

toon_voorplaat_als_grondplaat = true;
toon_voorplaat_als_voorplaat = false;
toon_achterplaat = true;        // rear panel is present by default
toon_bovenkap = true;
toon_eiken_lijst = true;
toon_plexiglas = true;
toon_epdm = true;
toon_stelplaatjes = true;
toon_pocketholes = montage_met_pocketholes;

// Aluminium subframe en HUB75-panelen kunnen afzonderlijk worden getoond.
toon_aluminium_frame = true;
toon_led_panelen = true;

use <../components/rubber_feet.scad>

/* [Hoofdmaten houten kast] */
// De voormalige binnenmaat van het displayvak blijft als vrije kastmaat behouden.
vrije_binnen_breedte = 846;
vrije_bovenbouw_hoogte = 365; // vaste binnenhoogte; 5 mm ruimte boven het 360 mm glas

frame_hout_dikte = 15;

// Dragende framedelen: zijwanden, bovenkap, tussenbodem,
// onderbodem en de twee schotten.
hout_dikte = frame_hout_dikte;
voorpaneel_hout_dikte = 10;
achterpaneel_hout_dikte = 10;
// Totale diepte inclusief de eiken voorlijst moet 100 mm zijn.
// De eiken lijst steekt 19-7 = 12 mm vóór de houten zijwand uit.
// Daarom wordt de houten kast-/zijwanddiepte 100-12 = 88 mm.
totale_zijwanddiepte_inclusief_eiken = 100;
kast_diepte = 88;

// Bovenplaat totaal 124 mm.
// Omdat de eiken lijst 12 mm vóór kast_y_voor uitsteekt, is voor een
// zichtbaar overstek van 12 mm aan de voorkant 24 mm nodig vanaf kast_y_voor.
// Aan de achterkant is 12 mm voldoende.
bovenkap_overstek_voor = 24;
bovenkap_overstek_achter = 12;
bovenkap_diepte = kast_diepte + bovenkap_overstek_voor + bovenkap_overstek_achter;
bovenkap_overlengte_per_zijde = 16;

/* [V1.1 roundwood carry structure] */
// V1.1 keeps the complete V1.0 case and replaces only the carrying/handle
// concept with an external Ø22 mm roundwood structure.
toon_roundwood_frame = true;
toon_roundwood_sockets = true;
toon_roundwood_cross_member = true;
toon_roundwood_center_supports = true;
/* [V1.1 slim upper wood geometry] */
// The lower storage compartment keeps the complete V1.0 depth. Only the
// upper display section is reduced. The end zones remain deeper so the
// roundwood sockets have a solid plywood attachment area.
v11_upper_center_depth = 60;
v11_upper_end_depth = 80;
v11_upper_end_straight_height = 30;
v11_upper_transition_radius = 20;
v11_top_end_straight_width = 30;

assert(
    v11_upper_end_depth <= kast_diepte,
    "V1.1 upper end depth must fit inside the V1.0 side-wall depth."
);
assert(
    v11_upper_center_depth + v11_upper_transition_radius
        == v11_upper_end_depth,
    "V1.1 R20 transition must connect the 60 and 80 mm depth zones."
);


/* [Onderste opbergvak] */
ondervak_inwendig_hoogte = 70;
tussenbodem_dikte = frame_hout_dikte;
onderbodem_dikte = frame_hout_dikte;

ondervak_schot_dikte = frame_hout_dikte;
ondervak_groef_speling = 0.6;
ondervak_groef_diepte = 3;
tussenbodem_zijgroef_diepte = 3; // tussenbodem valt 3 mm in beide zijwanden

/* [Houtbewerkingen zijwanden] */
serviceopening_breedte_y = 20;
serviceopening_hoogte_z = 34;
serviceopening_achterrand = 28;
serviceopening_onderrand = 18;


/* [Kunststof steunvoetjes onder de kast] */
// De twee middelste steunlatten behouden hun bestaande maatvoering,
// maar worden voortaan als kunststof onderdelen uitgevoerd.
houten_voet_hoogte = 10;
houten_voet_breedte = 15;
houten_voet_buiten_inset = 35;
kleur_kunststof_middenvoet = [0.15,0.75,0.20];

/* [Rubberen voeten onder de grondplaat] */
// Adam Hall 4900SM4AH: Ø25 mm, 11 mm hoog, montagegat Ø5,3 mm.
rubbervoet_diameter = 25;
rubbervoet_hoogte = 11;
rubbervoet_montagegat_d = 5.3;
rubbervoet_boven_diameter = 21;
rubbervoet_rand_inset_x = 35;
rubbervoet_rand_inset_y = 35;
kleur_rubbervoet = [0.05,0.05,0.05];
kleur_rubbervoet_schijf = [0.35,0.35,0.35];

// Basismaatvoering tong-en-groef, vroeg gedefinieerd omdat ook de
// kunststof onderbeugels deze waarden gebruiken.
multiplex_tong_dikte = 5;
multiplex_tong_diepte = 5;
multiplex_tong_schouder = (frame_hout_dikte-multiplex_tong_dikte)/2;

eiken_tonggroef_breedte = 5.3;
eiken_tonggroef_diepte = 5.2;

/* [Kunststof hoekbeugels onderzijde] */
// De buitenste houten voetjes worden vervangen door twee kunststof L-beugels.
hoekbeugel_breedte_y = 28; // volledige diepte van de bredere zijsteun
hoekbeugel_zijhoogte = 60;       // hoogte langs de zijwand
hoekbeugel_zijdikte_x = 10;      // dikte van het verticale deel naar buiten
hoekbeugel_voetlengte_x = 40;    // 20 mm verder onder de kast door
hoekbeugel_voethoogte_z = 10;    // vervangt het 10 mm hoge houten voetje

hoekbeugel_schroef_d = 4.3;

// Zijschroeven: twee hoogtes, door X in de zijwand.
hoekbeugel_zijgat_z = [18,44];

// Onderschroeven: twee X-posities, van onder naar boven.
hoekbeugel_ondergat_x = [10,30];

kleur_hoekbeugel = [0.15,0.75,0.20];

// Positioneerprofiel tussen hoekbeugels en centrale inzet.
// Zijaanzicht: eerst 1,5 mm rechte wand, daarna taps naar een smallere top.
kunststof_positioneer_lengte_y = 2.5;
kunststof_positioneer_top_y = 0; // niet meer gebruikt bij het doorlopende eindprofiel
kunststof_positioneer_recht_z = 1.5;
kunststof_positioneer_hoogte = 4;
kunststof_positioneer_speling = 0.25;

// Symmetrische passing van de onderste kunststof beugels rond de nieuwe
// 15 mm multiplexopbouw: 5 mm schouder + 5 mm tong + 5 mm schouder.
onderbeugel_tong_speling = 0.3;
onderbeugel_tong_breedte = multiplex_tong_dikte+onderbeugel_tong_speling;
onderbeugel_schouder_breedte = multiplex_tong_schouder;


/* [Handgreep] */

/* [Plexiglas en eiken lijst] */
plexiglas_breedte = 840;
plexiglas_hoogte = 360;       // vaste glasmaat
plexiglas_dikte = 4;              // standaard 4 mm
plexiglas_speling_achter_lijst = 0.5;

plexiglas_overlap = 7;            // overlap van eikenhout over plexiglas

// Basisvoorraad: eiken schaaflat 19 x 25 mm.
eiken_lijst_diepte = 19;          // maat loodrecht op de voorzijde
eiken_lat_nominale_breedte = 25;  // zichtbreedte vóór het op maat schaven
eiken_profiel_sponning_diepte = 4; // rechte lip vóór het plexiglas
eiken_profiel_schuinte = 5;        // terugloop van de schuine voorzijde

// Oude volledige opname blijft alleen als historische referentiemaat bestaan.
// De zijwand valt voortaan niet meer over de volle 15 mm in het eiken.
eiken_uitham_diepte = multiplex_tong_diepte;
eiken_uitham_speling = 0;
// De centrale multiplex tong valt circa 5 mm in de eiken groef.
eiken_aansluiting_overlap = multiplex_tong_diepte;
eiken_boven_groef_diepte = 5;    // bovenste glaslat valt 5 mm in de onderzijde van de bovenplaat
eiken_boven_groef_speling = 0.25;  // frees-/montagespeling rondom de bovenlat
eiken_boven_groef_eindspeling = 0; // groef loopt alleen tussen de zijlijsten, niet tot de plaatuiteinden

// Stelplaatjes vullen de 5 mm vrije ruimte boven het vaste plexiglas.
stelplaat_breedte = 30;
stelplaat_hoogte = vrije_bovenbouw_hoogte-plexiglas_hoogte;
stelplaat_dikte = plexiglas_dikte;
stelplaat_diepte = 6; // zichtbaar vanaf de binnenzijde, direct achter de glasrand
stelplaat_hartafstand = 420;

// EPDM wordt als kader op de voorzijde van het plexiglas geplakt.
epdm_strook_breedte = 9;
epdm_dikte = 1.5;
epdm_rand_inzet = 0;


/* [Metalen controleblokjes op grondplaat] */
metaalblok_dikte = 2;   // X-richting, van het scherm af
front_panel_insert_length = 50; // shared front-panel insert, hook and oak-trim interface length
metaalblok_lengte = 24; // fixed purchased metal hook plate length
metaalblok_hoogte = 20; // Z-richting; 6 mm boven de 10 mm grondplaat
metaalblok_hoekradius = 3;
metaalblok_gat_diameter = 4.3;
metaalblok_gat_hartafstand = 14;
metaalblok_gat_hoogte = 5; // midden in de 10 mm dikke grondplaat
kleur_metaalblok = [0.65,0.68,0.72];

/* [Eenvoudige klembeugel op zijwand] */
// Vlakke basisplaat.
klemplaat_dikte = 2;             // X, vanaf de zijwand naar buiten
klemplaat_breedte = 16.5;        // Y
klemplaat_lengte = 43;           // Z
// Geen handmatige hoogte-offset meer; plaatsing wordt uit de onderbeugel berekend.
klemplaat_gat_d = 4.2;
klemplaat_gat_hartafstand = 14;
klemplaat_eerste_gat_z = 23;   // lokaal vanaf onderzijde basisplaat

// Vereenvoudigde datasheetgeometrie K2475.
klem_totale_lengte = 73;         // datasheet, gesloten toestand
klem_basis_lengte = 43;          // datasheet
klem_basis_breedte = 16.5;       // datasheet
klem_totale_hoogte = 14.5;       // vorm A; eenvoudige controlehoogte
klem_spanbeugel_breedte = 23.5;  // buitenbreedte brede spanbeugel
// Rechthoekig profiel:
// 2 mm breed in het vlak van de beugel en 3 mm hoog vanaf de montageplaat.
klem_spanbeugel_breedte_profiel = 2; // Y bij de langsliggers
klem_spanbeugel_hoogte_profiel = 3;  // X, vanaf de montageplaat naar buiten
klem_spanbeugel_vrijstand = 1;       // vrije ruimte tussen plaat en beugel
klem_spanbeugel_uitsteek = 15.5;     // buitenzijde; binnenzijde is 13,5 mm
klem_scharnierpen_d = 4.2;
klem_scharnier_z = 13.5;         // eenvoudige eerste positie vanaf voorzijde
kleur_klemplaat = [0.58,0.61,0.66];

/* [Kunststof doorsteekinzet voor zijbeugel] */
// Kern in de rechthoekige uitsparing aan de plaatrand.
kunststof_kern_lengte = 24;        // Y, gelijk aan de metalen beugel
kunststof_kern_diepte = 16;        // X, meer materiaal rond bouten en moeruitsparingen

// Flens ligt boven en onder over het omliggende multiplex.
kunststof_flens_lengte = front_panel_insert_length;
kunststof_flens_diepte = 30;       // diepere overlap voor meer schroefruimte
kunststof_inzet_flens = 4;         // dikte boven en onder
kunststof_inzet_speling = 0.30;    // zichtbare passing rondom de kern

// Horizontale M4-bouten door metalen beugel en kunststof kern.
kunststof_boutgat_d = 4.3;
kunststof_bout_hartafstand = 14;
kunststof_bout_z = 5;
kunststof_moer_d = 8.2;
kunststof_moer_diepte = 3.5;

// Houtschroeven zitten uitsluitend in het flensdeel boven gezond multiplex,
// dus buiten de 16 mm diepe kern en buiten de horizontale boutbanen.
kunststof_houtschroef_d = 3.5;
kunststof_houtschroef_verzink_d = 7;
kunststof_houtschroef_verzink_h = 2;
// Schroefposities als [X vanaf plaatrand, Y lokaal in de flens].
// Boven en onder liggen bewust in verschillende X- én Y-zones.
kunststof_top_schroeven = [
    [8,8],
    [8,front_panel_insert_length-8]
];
kunststof_onder_schroeven = [
    [24,15],
    [24,front_panel_insert_length-15]
];

// Verdieping van de metalen onderdelen in hun montagevlak.
metaalblok_verdieping = 2;
klemplaat_verdieping = 2;
toon_tweede_klemset = true;

// Bovenste horizontale klemset voor de verticale voorplaat.
// Exacte Z-uitlijning van de bovenklem op de haak van de verticale voorplaat.
//
// De haak ligt in de horizontale grondplaat op scherm_y_hart.
// Na rotate([-90,0,0]) wordt de verticale Z-positie:
//     hout_buiten_z_min - scherm_y_hart
//
// Deze waarde wordt pas na de afgeleide kastmaten gebruikt.
bovenklem_afstand_vanaf_boven = 0; // niet meer gebruiken voor positionering
// Vierkante inkeping, geschikt voor de zaagtafel.
// 7 mm totaal: 5 mm vrije ruimte + 2 mm kunststof bescherming.
bovenklem_lijst_vrijloop = 5;
glaslat_inkeping_diepte = 9; // 2 mm extra diepte voor terugliggende kunststof poot
glaslat_inkeping_hoogte = front_panel_insert_length;

glaslat_beschermprofiel_dikte = 2;
glaslat_beschermprofiel_schroef_d = 3.5;
glaslat_beschermprofiel_gat_z = [8,42];
toon_glaslat_beschermprofielen = true;
kleur_glaslat_beschermprofiel = [0.18,0.72,0.24,1];

// Doorlopende geleiding vanaf de voorrand naar de horizontale klem.
bovenklem_geleidebaan_diepte = 4;      // totale freesdiepte in zijwand
bovenklem_geleider_dikte = 2;          // kunststof bekleding
bovenklem_geleider_netto_verdieping = 2; // klem schuift 2 mm vrij langs geleider
bovenklem_geleider_lengte_y = 40; // 30 mm clamp section + 10 mm beyond the wood
bovenklem_geleider_hoogte = 50; // gelijk aan de volledige L-profielhoogte

bovenklem_lijst_speling_z = 1;

// Ruimere freesuitsparing rond de horizontale bovenklem.
bovenklem_uitsparing_lengte_y = 50;
bovenklem_uitsparing_hoogte_z = 30;
bovenklem_uitsparing_speling_voor_y = 3;

klemuitsparing_breedte = front_panel_insert_length;

kleur_kunststof_zadel = [0.35,0.65,0.20];

assert(klemplaat_lengte == 43,
    "De basisplaat van de klem moet 43 mm lang zijn.");
assert(klemplaat_breedte == 16.5,
    "De basisplaat van de klem moet 16,5 mm breed zijn.");
assert(klemplaat_dikte == 2,
    "De basisplaat van de klem moet 2 mm dik zijn.");
assert(klemplaat_gat_hartafstand == 14,
    "De montagegaten van de klem moeten 14 mm hart-op-hart liggen.");
assert(klem_basis_lengte == 43,
    "Het basiselement moet volgens de datasheet 43 mm lang zijn.");
assert(klem_basis_breedte == 16.5,
    "Het basiselement moet volgens de datasheet 16,5 mm breed zijn.");
assert(klem_spanbeugel_breedte == 23.5,
    "De brede spanbeugel moet volgens de datasheet 23,5 mm breed zijn.");
assert(klem_totale_lengte == 73,
    "De gesloten spansluiting moet volgens de datasheet 73 mm lang zijn.");
assert(metaalblok_hoogte > 0,
    "De berekende klemhoogte vereist een geldige hoogte van de onderste beugel.");
assert(klem_spanbeugel_uitsteek == 15.5,
    "De buitenmaat van de spanbeugel moet 15,5 mm zijn.");
assert(klem_spanbeugel_breedte_profiel == 2,
    "Het spanbeugelprofiel moet 2 mm breed zijn.");
assert(klem_spanbeugel_hoogte_profiel == 3,
    "Het spanbeugelprofiel moet 3 mm hoog vanaf de montageplaat zijn.");
assert(klem_spanbeugel_vrijstand == 1,
    "De spanbeugel moet 1 mm vrij van de montageplaat liggen.");

assert(kast_y_voor + hoekbeugel_breedte_y <= kast_y_achter,
    "De voorste hoekbeugel moet volledig binnen de kastdiepte passen.");
assert(kast_y_achter - hoekbeugel_breedte_y >= kast_y_voor,
    "De achterste hoekbeugel moet volledig binnen de kastdiepte passen.");

assert(metaalblok_verdieping == 2,
    "De onderste metalen haakplaat moet 2 mm verdiept liggen.");
assert(klemplaat_verdieping == 2,
    "De bovenste klemplaat moet 2 mm verdiept liggen.");
assert(
    klemuitsparing_breedte == front_panel_insert_length,
    "The hook recess width must match front_panel_insert_length."
);
assert(klemuitsparing_breedte > klemplaat_breedte,
    "De houten uitsparing moet breder zijn dan de metalen klemplaat.");

assert(rubbervoet_diameter == 25,
    "De rubbervoet moet Ø25 mm zijn.");
assert(rubbervoet_hoogte == 11,
    "De rubbervoet moet 11 mm hoog zijn.");
assert(rubbervoet_montagegat_d == 5.3,
    "Het montagegat moet Ø5,3 mm zijn.");

/* [Aluminium frame en HUB75-panelen] */
// Hoofdmaatvoering overgenomen uit aluminium_v0p8.scad.
// Klemblokken, DIN-rails, kabelclips en elektronica zijn niet meegenomen.
alu_profiel_maat = 20;
alu_frame_breedte = 840;
alu_frame_hoogte = 360;
alu_staander_lengte = 320;

led_paneel_breedte = 159.70;
led_paneel_hoogte = 319.71;
led_paneel_dikte = 13.00;
led_paneel_aantal = 5;

// Gemonteerde EPDM-laag tussen plexiglas en aluminiumframe.
alu_epdm_dikte = 2.5;

// Paneelvoorzijde ligt 1 mm achter het aluminium voorvlak.
led_paneel_verdieping = 1;

kleur_aluminium = [0.70,0.72,0.74,1];
kleur_led_voorkant = [0.015,0.015,0.015,1];
kleur_led_pcb = [0.02,0.20,0.07,1];
kleur_led_achterkant = [0.07,0.08,0.07,1];

alu_explode_y = 55;
led_panelen_explode_y = 85;

assert(alu_frame_breedte == plexiglas_breedte,
    "Het aluminium frame moet 840 mm breed zijn, gelijk aan het plexiglas.");
assert(alu_frame_hoogte == plexiglas_hoogte,
    "Het aluminium frame moet 360 mm hoog zijn, gelijk aan het plexiglas.");
assert(led_paneel_aantal == 5,
    "Het aluminium subframe moet vijf HUB75-panelen bevatten.");
assert(led_paneel_aantal*led_paneel_pitch == alu_binnen_breedte,
    "De vijf paneelvakken moeten de volledige binnenbreedte vullen.");
assert(led_paneel_breedte <= led_paneel_pitch,
    "De HUB75-panelen moeten binnen hun framevakken passen.");

assert(exploded_haak_y < 0 && exploded_klem_y > 0,
    "In exploded view moeten haak en klem in tegengestelde Y-richting bewegen.");
assert(exploded_klem_y-exploded_haak_y >= 30,
    "Haak en klem moeten horizontaal voldoende uit elkaar staan.");

assert(bovenkap_overlengte_per_zijde == 16,
    "De bovenplaat moet links en rechts 16 mm verlengd zijn.");

assert(!(toon_voorplaat_als_grondplaat && toon_voorplaat_als_voorplaat),
    "De voorplaat kan niet tegelijk grondplaat en gemonteerde voorplaat zijn.");
assert(toon_voorplaat_als_grondplaat || toon_voorplaat_als_voorplaat,
    "Kies minstens één gebruikswijze voor de voorplaat.");

assert(gemonteerde_voorplaat_y+voorpaneel_hout_dikte
    == eiken_lijst_voor_y,
    "Het achtervlak van de gemonteerde voorplaat moet tegen de voorzijde van de eiken lijst liggen.");
assert(gemonteerde_voorplaat_y < eiken_lijst_voor_y,
    "De gemonteerde voorplaat moet volledig vóór de eiken lijst liggen.");

assert(gemonteerde_voorplaat_y+voorpaneel_hout_dikte
    == eiken_lijst_voor_y,
    "De verticale voorplaat moet volledig vóór de eiken lijst liggen.");

assert(bovenklem_hart_z_exact > tussenbodem_boven_z,
    "De horizontale tweede klemset moet boven de middenplaat liggen.");
assert(klem_basis_lengte <= kast_diepte,
    "De horizontale montageplaat moet binnen de diepte van de zijwand passen.");

assert(klemplaat_verdieping == 2,
    "De bovenste montageplaat moet 2 mm in de houten zijwand liggen.");
assert(bovenklem_lijst_vrijloop == 5,
    "De eiken glaslijst moet 5 mm ruimte krijgen voor de bovenklem.");
assert(klem_basis_lengte <= kast_diepte,
    "De horizontale montageplaat moet binnen de zijwanddiepte passen.");
assert(
    bovenklem_hart_z_exact-klem_basis_breedte/2
        > tussenbodem_boven_z,
    "De exact uitgelijnde bovenklem moet boven de middenplaat liggen."
);

assert(klem_basis_lengte <= kast_diepte,
    "De horizontale montageplaat moet vanaf de voorrand binnen de zijwand passen.");

assert(bovenklem_uitsparing_lengte_y > klem_basis_lengte,
    "De bovenste freesuitsparing moet langer zijn dan de 43 mm klemplaat.");
assert(bovenklem_uitsparing_hoogte_z > klem_basis_breedte,
    "De bovenste freesuitsparing moet hoger zijn dan de 16,5 mm klemplaat.");
assert(bovenklem_uitsparing_lengte_y == 50,
    "De bovenste freesuitsparing moet voorlopig 50 mm lang zijn.");
assert(bovenklem_uitsparing_hoogte_z == 30,
    "De bovenste freesuitsparing moet voorlopig 30 mm hoog zijn.");

assert(bovenklem_lijst_vrijloop == 5,
    "De eiken glaslijst moet 5 mm verdiept worden.");
assert(bovenklem_uitsparing_lengte_y == 50,
    "De glaslatvrijloop moet over de volledige 50 mm klemzone lopen.");
assert(bovenklem_uitsparing_hoogte_z == 30,
    "De glaslatvrijloop moet dezelfde 30 mm hoogte als de klemzone volgen.");

assert(bovenklem_lijst_vrijloop == 5,
    "De inkeping in de glaslat moet 5 mm diep in Y zijn.");

assert(glaslat_inkeping_diepte == 9,
    "De glaslatinkeping moet 9 mm diep zijn voor de 2 mm terugliggende kunststof poot.");
assert(glaslat_inkeping_hoogte == 50,
    "De vierkante inkeping moet 50 mm hoog zijn.");
assert(glaslat_beschermprofiel_dikte == 2,
    "Het kunststof beschermprofiel moet 2 mm dik zijn.");
assert(
    glaslat_inkeping_diepte-glaslat_beschermprofiel_dikte == 7,
    "Voor de terugliggende kunststof voorpoot moet 7 mm ruimte overblijven."
);

assert(bovenklem_geleidebaan_diepte == 4,
    "De geleidebaan moet 4 mm diep zijn.");
assert(bovenklem_geleider_dikte == 2,
    "De kunststof geleider moet 2 mm dik zijn.");
assert(bovenklem_geleidebaan_diepte-bovenklem_geleider_dikte
    == bovenklem_geleider_netto_verdieping,
    "Het geleidevlak moet 2 mm onder het houtoppervlak blijven.");
assert(glaslat_inkeping_diepte == 9,
    "De glaslatinkeping moet 9 mm diep zijn voor de 2 mm terugliggende kunststof poot.");
assert(bovenklem_geleidebaan_diepte == 4,
    "De zijwaartse zaagsnede moet 4 mm diep zijn.");
assert(glaslat_beschermprofiel_dikte == 2,
    "Beide poten van het kunststof L-profiel moeten 2 mm dik zijn.");
assert(
    glaslat_inkeping_diepte-glaslat_beschermprofiel_dikte == 7,
    "Voor de terugliggende kunststof voorpoot moet 7 mm ruimte overblijven."
);
assert(
    bovenklem_geleidebaan_diepte-glaslat_beschermprofiel_dikte
        == klemplaat_verdieping,
    "De kunststof zijpoot moet 2 mm verdiept blijven voor de klem."
);

assert(klemplaat_verdieping == 2,
    "De doorlopende basisverdieping moet 2 mm diep zijn.");
assert(eiken_lijst_achter_y > kast_y_voor,
    "De achterzijde van de eiken lijst moet achter de houten voorrand liggen.");

assert(glaslat_beschermprofiel_gat_z[0] == 8
    && glaslat_beschermprofiel_gat_z[1] == 42,
    "De schroefgaten moeten op 8 en 42 mm staan.");
assert(bovenklem_geleidebaan_diepte-glaslat_beschermprofiel_dikte == 2,
    "De kunststof zijpoot moet 2 mm onder het houtoppervlak blijven.");

assert(bovenklem_geleidebaan_diepte == 4,
    "De volledige geleidebaan moet werkelijk 4 mm diep worden uitgefreesd.");
assert(glaslat_beschermprofiel_dikte == 2,
    "Het kunststof glijvlak moet 2 mm dik zijn.");
assert(
    bovenklem_geleidebaan_diepte-glaslat_beschermprofiel_dikte
        == klemplaat_verdieping,
    "Kunststof glijvlak en verzonken montageplaat moeten op hetzelfde vlak aansluiten."
);

assert(abs(onderste_klem_randafstand-5.5) < 0.001,
    "De effectieve onderste randafstand moet 5,5 mm zijn.");
assert(bovenklem_randafstand == onderste_klem_randafstand,
    "Boven- en onderklem moeten dezelfde effectieve randafstand gebruiken.");
assert(bovenklem_randafstand > 0,
    "De bovenklem moet iets van de voorrand af staan.");
assert(bovenklem_randafstand+klem_basis_lengte < kast_diepte,
    "De horizontale klemplaat moet binnen de zijwanddiepte blijven.");

assert(bovenklem_geleidebaan_diepte == 4,
    "De zijbaan in hout en glaslat moet overal 4 mm diep zijn.");
assert(glaslat_inkeping_diepte >= bovenklem_geleidebaan_diepte,
    "De voorinkeping moet minstens zo diep zijn als de zijbaan.");

assert(frame_hout_dikte == 15,
    "De dragende multiplex zijwand moet 15 mm dik zijn.");
assert(multiplex_tong_dikte == 5,
    "De multiplex tong moet 5 mm dik zijn.");
assert(multiplex_tong_diepte == 5,
    "De multiplex tong moet 5 mm diep zijn.");
assert(multiplex_tong_schouder == 5,
    "Bij 15 mm multiplex moeten beide schouders 5 mm zijn.");
assert(eiken_tonggroef_breedte == 5.3,
    "De eiken groef moet 5,3 mm breed zijn.");
assert(eiken_tonggroef_diepte == 5.2,
    "De eiken groef moet 5,2 mm diep zijn.");
assert(eiken_tonggroef_breedte > multiplex_tong_dikte,
    "De eiken groef moet iets breder zijn dan de multiplex tong.");
assert(eiken_tonggroef_diepte > multiplex_tong_diepte,
    "De eiken groef moet iets dieper zijn dan de multiplex tong.");

assert(frame_hout_dikte == 15,
    "De onderbeugelpassing is gebaseerd op 15 mm multiplex.");
assert(multiplex_tong_schouder == 5,
    "De tong moet aan beide kanten een schouder van 5 mm hebben.");
assert(multiplex_tong_dikte == 5,
    "De centrale tong moet 5 mm dik zijn.");
assert(
    abs(
        (
            2*onderbeugel_schouder_breedte
            +multiplex_tong_dikte
        )
        -frame_hout_dikte
    ) < 0.001,
    "De symmetrische 5-5-5 opbouw moet samen 15 mm zijn."
);

assert(eiken_lijst_voor_y < kast_y_voor,
    "De voorste onderbeugel moet vóór de houten zijwand op de schermhoek liggen.");
assert(kast_y_achter-hoekbeugel_breedte_y > eiken_lijst_voor_y,
    "Voorste en achterste onderbeugel mogen niet overlappen.");

assert(
    abs(
        onderste_klem_y_hart_lokaal
        -(
            voorste_groene_binnenrand_y
            +achterste_groene_binnenrand_y
        )/2
    ) < 0.001,
    "De sluiting moet exact midden tussen de groene binnenranden staan."
);
assert(
    abs(
        onderste_klem_y_hart_lokaal-voorste_groene_binnenrand_y
    )
    ==
    abs(
        achterste_groene_binnenrand_y-onderste_klem_y_hart_lokaal
    ),
    "De vrije afstand links en rechts van de sluiting moet gelijk zijn."
);
assert(
    onderste_klem_y_hart_lokaal+klemplaat_breedte/2
        > kast_y_voor,
    "De onderste klemuitsparing moet vanaf de zijwandrand tot onder de klem lopen."
);

assert(
    hout_buiten_z_min
    <
    (
        (
            onderbodem_onder_z
            -houten_voet_hoogte
            -voorpaneel_hout_dikte
        )
        +metaalblok_hoogte/2
        +klem_spanbeugel_uitsteek
    ),
    "De onderste freesbaan moet vanaf de onderrand omhoog lopen."
);
assert(
    klem_basis_breedte
        -2*klem_spanbeugel_breedte_profiel
    > 0,
    "De ingekorte scharnierpen moet een positieve lengte houden."
);

assert(
    (
        (
            (
                onderbodem_onder_z
                -houten_voet_hoogte
                -voorpaneel_hout_dikte
            )
            +metaalblok_hoogte/2
            +klem_spanbeugel_uitsteek
        )
        +klemplaat_lengte
    )
    > hout_buiten_z_min,
    "De verticale freesstrook moet vanaf de klemzone tot de onderrand lopen."
);

assert(
    klemuitsparing_breedte == front_panel_insert_length,
    "The hook recess width must match front_panel_insert_length."
);
assert(klemplaat_verdieping == 2,
    "Pocket en neerwaartse verlenging moeten beide 2 mm diep zijn.");

assert(klemplaat_verdieping == 2,
    "De kopse groef in de onderplank moet 2 mm diep zijn.");
assert(
    klemuitsparing_breedte == front_panel_insert_length,
    "The hook recess width must match front_panel_insert_length."
);

assert(
    abs(
        (onderklem_groef_y1-onderklem_groef_y0)
        -klemuitsparing_breedte
    ) < 0.001,
    "Zijwand en onderplank moeten exact dezelfde groefbreedte gebruiken."
);
assert(klemplaat_verdieping == 2,
    "Beide delen van de doorlopende groef moeten 2 mm diep zijn.");

assert(hoekbeugel_breedte_y == 28,
    "De onderste zijsteunen moeten 28 mm breed zijn.");
assert(
    2*onderbeugel_schouder_breedte+onderbeugel_tong_breedte
        >= frame_hout_dikte,
    "De symmetrische passing moet de volledige multiplexrand omvatten."
);

assert(hoekbeugel_breedte_y == 28,
    "De onderste zijsteunen moeten 28 mm breed blijven.");
assert(kunststof_positioneer_lengte_y == 2.5,
    "De uitsparing moet lokaal 2,5 mm lang blijven in Y.");
assert(hoekbeugel_zijdikte_x == 10,
    "De verlenging naar de buitenrand gebruikt de 10 mm dikke verticale poot.");

assert(kunststof_positioneer_lengte_y == 2.5,
    "De basisuitsparing moet lokaal 2,5 mm lang blijven.");
assert(kunststof_positioneer_recht_z == 1.5,
    "Het schuine extra stuk moet eerst 1,5 mm recht blijven.");

assert(kunststof_positioneer_lengte_y == 2.5,
    "De uitsparing moet 2,5 mm lang blijven in de diepte.");
assert(hoekbeugel_breedte_y > kunststof_positioneer_lengte_y,
    "De lokale uitsparing moet binnen de 28 mm diepe steun passen.");

assert(kunststof_positioneer_lengte_y == 2.5,
    "De profieluitsparing moet 2,5 mm lang zijn.");
assert(kunststof_positioneer_recht_z == 1.5,
    "Het profiel moet eerst 1,5 mm recht lopen.");
assert(kunststof_positioneer_hoogte > kunststof_positioneer_recht_z,
    "Na het rechte deel moet een schuine overgang overblijven.");

assert(glaslat_beschermprofiel_dikte == 2,
    "Beide poten van het kunststof L-profiel moeten 2 mm dik zijn.");
assert(bovenklem_geleider_netto_verdieping == 2,
    "Het zichtvlak van de geleider moet 2 mm verdiept liggen.");

assert(glaslat_beschermprofiel_dikte == 2,
    "Beide poten van het kunststof L-profiel moeten 2 mm dik zijn.");
assert(glaslat_inkeping_diepte > glaslat_beschermprofiel_dikte,
    "De gezamenlijke hoeklijn moet achter het voorvlak van de glaslat liggen.");

assert(
    bovenklem_geleider_lengte_y >= 40,
    "The side-clamp guide must cover the 30 mm clamp section and 10 mm overhang."
);

assert(
    front_panel_insert_length == 50,
    "The front-panel insert interface must remain 50 mm long."
);
assert(
    klemuitsparing_breedte == kunststof_flens_lengte
    && glaslat_inkeping_hoogte == kunststof_flens_lengte,
    "The front-panel insert, receiving recess and oak-trim opening must have equal length."
);

assert(
    kunststof_top_schroeven[1][1] < front_panel_insert_length,
    "Both top screw holes must remain inside the front-panel insert."
);
assert(
    kunststof_onder_schroeven[1][1] < front_panel_insert_length,
    "Both bottom screw holes must remain inside the front-panel insert."
);

/* [Afgeleide kastmaten] */
kast_y_voor = -voorpaneel_hout_dikte;
kast_y_achter = kast_y_voor + kast_diepte;

bovenbouw_onder_z = 0;
bovenbouw_boven_z = vrije_bovenbouw_hoogte;

tussenbodem_boven_z = bovenbouw_onder_z;
tussenbodem_onder_z = tussenbodem_boven_z - tussenbodem_dikte;
ondervak_onder_z = tussenbodem_onder_z - ondervak_inwendig_hoogte;
onderbodem_onder_z = ondervak_onder_z - onderbodem_dikte;
onderbodem_boven_z = onderbodem_onder_z + onderbodem_dikte;


hout_buiten_x_min = -hout_dikte;
hout_buiten_x_max = vrije_binnen_breedte + hout_dikte;
hout_buiten_breedte = hout_buiten_x_max - hout_buiten_x_min;

hout_buiten_z_min = onderbodem_onder_z;
hout_buiten_z_max = vrije_bovenbouw_hoogte + hout_dikte;
hout_buiten_hoogte = hout_buiten_z_max - hout_buiten_z_min;

bovenkap_totale_breedte =
    hout_buiten_breedte + 2*bovenkap_overlengte_per_zijde;

// Plexiglas horizontaal gecentreerd. Verticaal staat het op de onderzijde;
// de volledige 5 mm stelruimte blijft uitsluitend aan de bovenzijde.
plexiglas_x_min = (vrije_binnen_breedte-plexiglas_breedte)/2;
plexiglas_x_max = plexiglas_x_min + plexiglas_breedte;
plexiglas_z_min = 0;
plexiglas_z_max = plexiglas_z_min + plexiglas_hoogte;
// De geometrie van de eiken overlaplip blijft exact zoals in v117.
// Deze vaste referentie is de voormalige voorzijde van de EPDM-strook.
eiken_lijst_lip_y = kast_y_voor-plexiglas_dikte-epdm_dikte;

// EPDM en plexiglas liggen nu ACHTER de volledige eiken lijst.
// Opbouw van voor naar achter:
// eiken achtervlak -> 0,5 mm montagespeling -> EPDM -> plexiglas.
epdm_y_achter_lijst =
    kast_y_voor+eiken_aansluiting_overlap+plexiglas_speling_achter_lijst;
plexiglas_y_voor = epdm_y_achter_lijst+epdm_dikte;

plexiglas_y_achter = plexiglas_y_voor+plexiglas_dikte;

// Aluminium frame and panels are centered on the 840 x 360 mm plexiglass.
alu_frame_x_min = plexiglas_x_min;
alu_frame_z_min = plexiglas_z_min;
alu_frame_y_voor = plexiglas_y_achter+alu_epdm_dikte;
alu_frame_y_achter = alu_frame_y_voor+alu_profiel_maat;

alu_binnen_breedte = alu_frame_breedte-2*alu_profiel_maat;
led_paneel_pitch = alu_binnen_breedte/led_paneel_aantal;
led_paneel_x_marge = (led_paneel_pitch-led_paneel_breedte)/2;
led_paneel_z_offset =
    alu_profiel_maat+(alu_staander_lengte-led_paneel_hoogte)/2;
led_paneel_y_voor = alu_frame_y_voor+led_paneel_verdieping;

function led_paneel_x(index) =
    alu_frame_x_min
    +alu_profiel_maat
    +index*led_paneel_pitch
    +led_paneel_x_marge;

// Eiken lijst ligt over de volledige buitencontour rond het displayvak.
// De binnenopening wordt rechtstreeks uit de pleximaat en 7 mm overlap bepaald.
eiken_lijst_buiten_x_min = hout_buiten_x_min;
eiken_lijst_buiten_x_max = hout_buiten_x_max;
eiken_lijst_buiten_z_min = tussenbodem_onder_z;
// De horizontale onderregel blijft bij het glasvak; de verticale zijlijsten
// lopen als één stuk door tot op de BOVENZIJDE van de onderste horizontale plaat.
// Zo steken de stijlen niet links/rechts langs de plaatdikte naar beneden door.
eiken_zijstijl_z_min = ondervak_onder_z;
// De bovenregel valt 5 mm in een lokale groef in de onderzijde van het dakje.
// De verticale zijlijsten blijven tegen de onderzijde van de bovenplaat eindigen.
eiken_lijst_buiten_z_max = vrije_bovenbouw_hoogte + eiken_boven_groef_diepte;

eiken_lijst_opening_x_min = plexiglas_x_min + plexiglas_overlap;
eiken_lijst_opening_x_max = plexiglas_x_max - plexiglas_overlap;
eiken_lijst_opening_z_min = plexiglas_z_min + plexiglas_overlap;
eiken_lijst_opening_z_max = plexiglas_z_max - plexiglas_overlap;

eiken_lijst_buiten_breedte =
    eiken_lijst_buiten_x_max-eiken_lijst_buiten_x_min;
eiken_lijst_buiten_hoogte =
    eiken_lijst_buiten_z_max-eiken_lijst_buiten_z_min;
eiken_lijst_opening_breedte =
    eiken_lijst_opening_x_max-eiken_lijst_opening_x_min;
eiken_lijst_opening_hoogte =
    eiken_lijst_opening_z_max-eiken_lijst_opening_z_min;

eiken_lijst_zijbreedte =
    (eiken_lijst_buiten_breedte-eiken_lijst_opening_breedte)/2;
eiken_lijst_onderregel_breedte =
    eiken_lijst_opening_z_min-eiken_lijst_buiten_z_min;
eiken_lijst_bovenregel_breedte =
    eiken_lijst_buiten_z_max-eiken_lijst_opening_z_max;
// Compatibiliteitswaarde voor controles/echo.
eiken_lijst_horizontale_breedte =
    max(eiken_lijst_onderregel_breedte,eiken_lijst_bovenregel_breedte);

// Het eiken profiel grijpt alleen om de houten zijwand. Aan de glaszijde stopt
// het profiel vóór het plexiglas: EPDM en glas liggen vlak tegen de achterzijde
// van de overlaplip, zonder een houten strook langs de glasrand.
eiken_lijst_achter_y = kast_y_voor + eiken_aansluiting_overlap;
eiken_lijst_voor_y = eiken_lijst_achter_y-eiken_lijst_diepte;

// Wanneer dezelfde plaat als echte voorplaat wordt gebruikt, ligt haar
// achtervlak tegen de voorzijde van de eiken lijst.
gemonteerde_voorplaat_y =
    eiken_lijst_voor_y-voorpaneel_hout_dikte;

ondervak_x_min = hout_buiten_x_min + hout_dikte;
ondervak_x_max = hout_buiten_x_max - hout_dikte;
ondervak_binnen_breedte = ondervak_x_max - ondervak_x_min;
ondervak_schot_x1 = ondervak_x_min + ondervak_binnen_breedte/3;
ondervak_schot_x2 = ondervak_x_min + 2*ondervak_binnen_breedte/3;

// Onderplaat en schotten lopen naar voren door tot de voorzijde van de eiken lijst.
onderbodem_y_min = eiken_lijst_voor_y;
onderbodem_diepte_verlengd = kast_y_achter-onderbodem_y_min;
ondervak_schot_y_min = onderbodem_y_min;
ondervak_schot_diepte = onderbodem_diepte_verlengd;

// Vier houten voetjes/steunlatten lopen van voor naar achter onder de onderplaat.
houten_voet_diepte = onderbodem_diepte_verlengd;
houten_voet_y_min = onderbodem_y_min;
houten_voet_x_posities = [
    hout_buiten_x_min + houten_voet_buiten_inset,
    ondervak_schot_x1,
    ondervak_schot_x2,
    hout_buiten_x_max - houten_voet_buiten_inset
];

/* [Normale montageweergave] */
// Positie van de rechtopstaande kast op de liggende voorplaat.
// 0 = aan de voorrand, 1 = aan de achterrand.
montage_kast_fractie_vanaf_voorkant = 0.25;
montage_plaat_diepte = hout_buiten_hoogte;
montage_kast_y_shift =
    -montage_plaat_diepte
    + montage_kast_fractie_vanaf_voorkant * montage_plaat_diepte
    - kast_y_voor;

// Hartlijn van de metalen haak nadat de complete grondplaat verticaal is gezet.
verticale_haak_hart_z =
    hout_buiten_z_min
    -(
        montage_kast_y_shift
        +(kast_y_voor+kast_y_achter)/2
    );

// De bovenklem wordt exact op dezelfde Z-hartlijn geplaatst.
bovenklem_hart_z_exact = verticale_haak_hart_z;

// De onderste sluiting wordt exact gecentreerd tussen de BINNENRANDEN
// van de voorste en achterste groene hoekbeugel.
//
// Voorste binnenrand:
//     eiken_lijst_voor_y + hoekbeugel_breedte_y
// Achterste binnenrand:
//     kast_y_achter - hoekbeugel_breedte_y
//
// Het gemiddelde vereenvoudigt tot:
//     (eiken_lijst_voor_y + kast_y_achter) / 2
voorste_groene_binnenrand_y =
    eiken_lijst_voor_y+hoekbeugel_breedte_y;

achterste_groene_binnenrand_y =
    kast_y_achter-hoekbeugel_breedte_y;

onderste_klem_y_hart_lokaal =
    (
        voorste_groene_binnenrand_y
        +achterste_groene_binnenrand_y
    )/2;

onderste_klem_y_hart =
    montage_kast_y_shift+onderste_klem_y_hart_lokaal;

// Gedeelde maatvoering voor de doorlopende 2 mm groef achter de onderste sluiting.
onderklem_groef_y0 =
    onderste_klem_y_hart_lokaal-klemuitsparing_breedte/2;
onderklem_groef_y1 =
    onderste_klem_y_hart_lokaal+klemuitsparing_breedte/2;

// Effectieve randafstand van de onderste klem, inclusief het 10 mm voetje.
// Deze afstand wordt ook voor de horizontale bovenklem gebruikt.
onderste_klem_randafstand =
    -houten_voet_hoogte
    -voorpaneel_hout_dikte
    +metaalblok_hoogte/2
    +klem_spanbeugel_uitsteek;

bovenklem_randafstand = onderste_klem_randafstand;

// Beginpositie van de horizontale montageplaat binnen de zijwand.
bovenklem_montage_y =
    montage_kast_y_shift
    +kast_y_voor
    +bovenklem_randafstand;

assert(
    bovenklem_hart_z_exact == verticale_haak_hart_z,
    "Hartlijn van bovenklem en verticale haak moet exact gelijk zijn."
);

/* [Exploded view] */
hout_explode_x = 130;
hout_explode_z = 95;
plexiglas_explode_y = -55;
epdm_explode_y = -78;
stelplaat_explode_y = -96;
eiken_lijst_explode_y = -125;
eiken_deel_explode_x = 65;
eiken_deel_explode_z = 55;
grondplaat_explode_z = -165;
voorplaat_explode_y = -80;
achterpaneel_explode_y = 80;
klemmen_explode_z = grondplaat_explode_z;
inzet_explode_x = 45;
exploded_haak_y = -18;
exploded_klem_y = 18;

voetjes_explode_z = -55;

/* [Montage met pocket holes] */
// Pocket-holevariant:
// 1. zijwanden van binnenuit aan de bovenplaat;
// 2. tussenbodem van bovenaf aan beide zijwanden;
// 3. staanders met pocket holes aan de buitenzijde, alleen omhoog naar de tussenbodem;
// 4. de 3 mm verbinding met de tussenbodem wordt zichtbaar als een smalle tong boven op elke staander.
// Custom 3D-geprinte hoekbeugels zijn in deze variant bewust weggelaten.
pockethole_diameter = 9;
pockethole_pilot_diameter = 4;
pockethole_lengte = 34;
pockethole_hoek = 15;
pockethole_randafstand_y = 24;
pockethole_randafstand_z = 24;

montageschroef_d = 4;
montageschroef_kop_d = 8;
montageschroef_lengte = 16;
montageschroef_kophoogte = 2.5;

pockethole_plaat_randafstand_x = 10;
// De tong boven op de staanders valt 3 mm in de groef van de tussenbodem.
// Een kleine Y-inspringing maakt de verbinding zichtbaar en voorkomt botsing met de voorlijst.
schot_tong_inset_y = 3;

/* [Kleuren] */
kleur_hout = [0.68,0.42,0.20,1];
kleur_hout_kop = [0.76,0.50,0.27,1];
kleur_eiken = [0.86,0.66,0.36,1];
kleur_plexiglas = [0.66,0.86,0.95,0.38];
kleur_epdm = [0.08,0.08,0.08,1];
kleur_stelplaat = [0.35,0.35,0.35,1];
kleur_handgreep = [0.28,0.29,0.30,1];

/* [Controles] */
assert(hout_dikte > 0, "Houtdikte moet groter dan nul zijn.");
assert(houten_voet_hoogte == 10, "De kunststof middenvoetjes moeten 10 mm hoog zijn.");
assert(metaalblok_dikte == 2, "De metalen blokjes moeten 2 mm dik zijn.");
assert(
    metaalblok_lengte == 24,
    "The purchased metal hook plate must remain 24 mm long."
);
assert(metaalblok_hoogte == 20, "De platte zijbeugel moet 20 mm hoog zijn.");
assert(metaalblok_gat_diameter == 4.3, "De schroefgaten moeten Ø4,3 mm zijn.");
assert(metaalblok_gat_hoogte < voorpaneel_hout_dikte,
    "De schroefgaten moeten binnen de hoogte van de grondplaat vallen.");
assert(kunststof_inzet_flens == 4,
    "De kunststof inzet moet boven en onder 4 mm overlappen.");
assert(kunststof_kern_lengte == 24,
    "De kunststof kern moet gelijk zijn aan de 24 mm brede metalen beugel.");
assert(kunststof_bout_hartafstand == 14,
    "De horizontale boutgaten moeten 14 mm hart-op-hart liggen.");
assert(kunststof_top_schroeven[0][0] != kunststof_onder_schroeven[0][0],
    "Boven- en onderschroeven moeten verschillende X-zones gebruiken.");
assert(kunststof_top_schroeven[0][1] != kunststof_onder_schroeven[0][1]
    && kunststof_top_schroeven[1][1] != kunststof_onder_schroeven[1][1],
    "Boven- en onderschroeven moeten ook in Y versprongen staan.");
assert(kunststof_flens_diepte >= 30,
    "De flens moet diep genoeg zijn voor twee gescheiden schroefzones.");
assert(kunststof_flens_lengte > kunststof_kern_lengte,
    "De kunststof flens moet breder zijn dan de metalen beugel/kern.");
assert(kunststof_kern_diepte == 16,
    "De kunststof kern moet 16 mm diep zijn voor extra materiaal rond de M4-bouten.");
assert(
    kunststof_onder_schroeven[0][1] == 15
    && kunststof_onder_schroeven[1][1]
        == front_panel_insert_length-15,
    "The bottom screw positions must remain symmetric inside the insert."
);
assert(kunststof_top_schroeven[0][1] != kunststof_onder_schroeven[0][1]
    && kunststof_top_schroeven[1][1] != kunststof_onder_schroeven[1][1],
    "Boven- en onderschroeven moeten in Y versprongen staan.");
assert(houten_voet_breedte == 15, "De kunststof middenvoetjes moeten 15 mm breed zijn.");
assert(kunststof_positioneer_recht_z == 1.5,
    "De eerste 1,5 mm van het profiel moet recht omhoog lopen.");
assert(kunststof_positioneer_hoogte == kunststof_inzet_flens,
    "Het positioneerprofiel moet even hoog zijn als de bovenflens.");

assert(hoekbeugel_breedte_y == 28,
    "De kunststof hoekbeugel moet 28 mm breed zijn.");
assert(hoekbeugel_zijhoogte == 60,
    "Het verticale beschermdeel moet 60 mm hoog zijn.");
assert(hoekbeugel_voethoogte_z == 10,
    "Het voetdeel moet 10 mm hoog zijn.");
assert(hoekbeugel_voetlengte_x == 40,
    "De horizontale poot moet 40 mm onder de kast doorlopen.");
assert(hoekbeugel_breedte_y <= houten_voet_diepte,
    "De hoekbeugel moet binnen de diepte van de kast passen.");

assert(vrije_binnen_breedte == 846, "Vrije binnenbreedte moet 846 mm zijn.");
assert(vrije_bovenbouw_hoogte == 365, "Vrije binnenhoogte moet 365 mm zijn.");
assert(kast_diepte > voorpaneel_hout_dikte + achterpaneel_hout_dikte,
    "Kastdiepte is te klein voor de voor- en achterplaat.");
assert(ondervak_inwendig_hoogte > 2*ondervak_groef_diepte,
    "Het onderste vak is te laag voor de gekozen schotgroeven.");
assert(ondervak_groef_diepte == 3, "De haakse verbindingsgroeven moeten 3 mm diep zijn.");
assert(tussenbodem_zijgroef_diepte == 3, "De tussenbodem moet 3 mm in elke zijwand vallen.");
assert(kast_diepte == 88,
    "Tussenbodem en houten zijwanden moeten beide 88 mm diep zijn.");
assert(bovenkap_diepte == 124,
    "De bovenplaat moet exact 124 mm diep zijn.");
assert(eiken_lijst_diepte == 19,
    "Alle eiken lijstonderdelen moeten uit 19 mm dik materiaal worden gehaald.");
assert(eiken_lijst_achter_y-eiken_lijst_voor_y == eiken_lijst_diepte,
    "De eiken profieldiepte moet exact 19 mm zijn.");



assert(2*schot_tong_inset_y < ondervak_schot_diepte, "De tonginspringing is te groot voor de staanderdiepte.");
assert(montageschroef_lengte == 16, "De pocket-hole schroeven moeten 16 mm lang zijn.");
assert(plexiglas_breedte < vrije_binnen_breedte,
    "Plexiglas moet smaller zijn dan de vrije binnenbreedte.");
assert(plexiglas_hoogte == 360, "Plexiglashoogte moet vast 360 mm zijn.");
assert(stelplaat_hoogte == 5, "De stelruimte boven het glas moet 5 mm zijn.");
assert(plexiglas_overlap > 0 &&
       2*plexiglas_overlap < min(plexiglas_breedte,plexiglas_hoogte),
    "De plexiglasoverlap is ongeldig.");
assert(epdm_y_achter_lijst >= eiken_lijst_achter_y,
    "EPDM moet volledig achter de eiken lijst liggen.");
assert(plexiglas_y_voor == epdm_y_achter_lijst+epdm_dikte,
    "Plexiglas moet direct achter de EPDM-strook beginnen.");
assert(plexiglas_y_voor > eiken_lijst_achter_y,
    "Plexiglas mag niet binnen de eiken profieldiepte liggen.");
assert(eiken_lijst_zijbreedte <= eiken_lat_nominale_breedte,
    "De zijstijlen zijn breder dan de beschikbare schaaflat.");
assert(eiken_lijst_onderregel_breedte <= eiken_lat_nominale_breedte,
    "De onderregel is breder dan de beschikbare schaaflat.");
assert(eiken_lijst_bovenregel_breedte > 0 &&
       eiken_lijst_bovenregel_breedte <= eiken_lat_nominale_breedte,
    "De terugliggende bovenregel past niet uit de beschikbare schaaflat.");

echo("=== HOUTEN FRAME — 15 MM — 846 x 365 MM VRIJE BINNENMAAT ===");
echo(str("Buitenmaat B x H x D: ",
    hout_buiten_breedte, " x ", hout_buiten_hoogte, " x ", kast_diepte, " mm"));
echo(str("Vrije bovenbouw: ",
    vrije_binnen_breedte, " x ", vrije_bovenbouw_hoogte, " mm"));
echo(str("Dikte dragende framedelen: ", frame_hout_dikte, " mm"));
echo(str("Groefdiepte haakse verbindingen: ", ondervak_groef_diepte, " mm"));
echo(str("Pocket-hole schroeflengte: ", montageschroef_lengte, " mm"));
echo(str("Kunststof middenvoetjes: 2 stuks, ",
    houten_voet_breedte, " mm breed x ",
    houten_voet_diepte, " mm diep x ",
    houten_voet_hoogte, " mm hoog; buitenhoeken via kunststof L-beugels."));
echo(str("Bovenkap: ", bovenkap_totale_breedte, " x ",
    bovenkap_diepte, " x ", hout_dikte, " mm"));
echo(str("Plexiglas: ", plexiglas_breedte, " x ", plexiglas_hoogte,
    " x ", plexiglas_dikte, " mm"));
echo(str("Glasopbouw Y: eiken achtervlak ", eiken_lijst_achter_y,
    ", EPDM vanaf ", epdm_y_achter_lijst,
    ", plexiglas vanaf ", plexiglas_y_voor, " mm."));
echo(str("Zichtopening eiken lijst: ", eiken_lijst_opening_breedte,
    " x ", eiken_lijst_opening_hoogte, " mm"));
echo(str("Eiken lijst buitenmaat: ", eiken_lijst_buiten_breedte,
    " x ", eiken_lijst_buiten_hoogte, " x ", eiken_lijst_diepte, " mm"));
echo(str("Latbreedtes zij / onder / boven: ", eiken_lijst_zijbreedte,
    " / ", eiken_lijst_onderregel_breedte,
    " / ", eiken_lijst_bovenregel_breedte, " mm"));
echo(str("EPDM kader: ", epdm_strook_breedte, " mm breed x ", epdm_dikte, " mm dik."));
echo(str("Bovenplaat: ", bovenkap_diepte,
    " mm diep; zichtbaar overstek voor/achter: 12 / 12 mm."));
echo(str("Houten zijwand: ", kast_diepte,
    " mm diep; inclusief eiken voorlijst: ",
    totale_zijwanddiepte_inclusief_eiken, " mm."));

echo(str(
    "Exacte Z-uitlijning bovenklem/haak: ",
    bovenklem_hart_z_exact,
    " mm"
));
echo(str(
    "Berekende randafstand boven-/onderklem: ",
    bovenklem_randafstand,
    " mm (inclusief correctie voor 10 mm voetje)"
));
echo(str(
    "Onderste sluiting exact tussen groene beugels, Y-hart: ",
    onderste_klem_y_hart,
    " mm"
));
echo(str(
    "Groene binnenranden lokaal: ",
    voorste_groene_binnenrand_y,
    " en ",
    achterste_groene_binnenrand_y,
    " mm"
));
echo(str("Eiken zijprofiel: ", eiken_lijst_diepte, " mm diep, ",
    eiken_profiel_sponning_diepte, " mm rechte lip en ",
    eiken_profiel_schuinte, " mm schuine terugloop en ",
    eiken_uitham_diepte, " mm diepe uitham voor de zijwand."));

// ----------------------------------------------------------------------------
// V1.1 upper side-wall profile.
//
// Local 2D coordinates:
//   X = depth measured from kast_y_voor
//   Y = height measured from bovenbouw_onder_z
//
// The upper section is 60 mm deep through most of its height. At the lower
// and upper ends it remains 80 mm deep for 30 mm, with an R20 concave
// transition between both depths. This is the routed profile explored in the
// V1.1 concept study.
// ----------------------------------------------------------------------------
module v11_upper_side_profile_2d() {
    h = vrije_bovenbouw_hoogte-bovenbouw_onder_z;
    r = v11_upper_transition_radius;
    straight = v11_upper_end_straight_height;

    difference() {
        union() {
            square([v11_upper_center_depth,h]);

            square([
                v11_upper_end_depth,
                straight+r
            ]);

            translate([0,h-straight-r])
                square([
                    v11_upper_end_depth,
                    straight+r
                ]);
        }

        translate([v11_upper_end_depth,straight+r])
            circle(r=r,$fn=64);

        translate([v11_upper_end_depth,h-straight-r])
            circle(r=r,$fn=64);
    }
}

module v11_upper_side_solid(x0) {
    // Same proven orientation used during the standalone V1.1 study:
    // the 2D depth/height profile is extruded through the plywood thickness.
    translate([x0,kast_y_voor,bovenbouw_onder_z])
        rotate([90,0,90])
            linear_extrude(height=hout_dikte)
                v11_upper_side_profile_2d();
}

// ----------------------------------------------------------------------------
// Linker of rechter zijwand.
// V1.1 retains the full-depth V1.0 lower storage wall, while the upper display
// wall uses the slimmer routed profile defined above.
// ----------------------------------------------------------------------------
module houten_zijwand(rechts=false) {
    x0 = rechts ? vrije_binnen_breedte : -hout_dikte;
    zijwand_z_max = vrije_bovenbouw_hoogte;
    zijwand_hoogte = zijwand_z_max - hout_buiten_z_min;
    binnen_x = rechts ? vrije_binnen_breedte : 0;
    richting = rechts ? 1 : -1;

    color(kleur_hout)
    difference() {
        union() {
            // V1.0 lower storage section remains full depth.
            translate([x0,kast_y_voor,hout_buiten_z_min])
                cube([
                    hout_dikte,
                    kast_diepte,
                    bovenbouw_onder_z-hout_buiten_z_min
                ]);

            // V1.1 slim upper display section.
            v11_upper_side_solid(x0);
        }

        // Twee zaagsneden van 5 mm diep maken een centrale tong van 5 x 5 mm.
        // De tongpunt blijft op kast_y_voor; de schouders beginnen 5 mm verder
        // naar achteren.
        translate([
            x0-0.1,
            kast_y_voor-0.1,
            hout_buiten_z_min-0.1
        ])
            cube([
                multiplex_tong_schouder+0.2,
                multiplex_tong_diepte+0.2,
                zijwand_hoogte+0.2
            ]);

        translate([
            x0+hout_dikte-multiplex_tong_schouder-0.1,
            kast_y_voor-0.1,
            hout_buiten_z_min-0.1
        ])
            cube([
                multiplex_tong_schouder+0.2,
                multiplex_tong_diepte+0.2,
                zijwand_hoogte+0.2
            ]);

        // Doorlopende 3 mm groef in de binnenzijde voor de tussenbodem.
        // De tussenbodem valt hierdoor werkelijk in beide zijwanden.
        translate([
            rechts ? binnen_x : binnen_x-tussenbodem_zijgroef_diepte,
            kast_y_voor-0.1,
            tussenbodem_onder_z
        ])
            cube([
                tussenbodem_zijgroef_diepte,
                kast_diepte+0.2,
                tussenbodem_dikte
            ]);

        // 2 mm diepe uitsparing aan de buitenzijde voor de klemplaat.
        // De positie volgt exact dezelfde berekening als de gemonteerde klem.
        grondplaat_boven_z_klem =
            onderbodem_onder_z-houten_voet_hoogte;
        grondplaat_onder_z_klem =
            grondplaat_boven_z_klem-voorpaneel_hout_dikte;
        onderste_beugel_hart_z_klem =
            grondplaat_onder_z_klem+metaalblok_hoogte/2;
        klem_z0 =
            onderste_beugel_hart_z_klem+klem_spanbeugel_uitsteek;
        // Deel A van de doorlopende groef:
        // 2 mm diep in de buitenzijde van de verticale zijwand.
        // Dit deel loopt vanaf de bovenzijde van de onderplank tot boven
        // de volledige onderste montageplaat.
        onderklem_frees_z0 =
            onderbodem_onder_z-0.1;
        onderklem_frees_z1 =
            klem_z0+klemplaat_lengte+0.1;

        translate([
            rechts
                ? hout_buiten_x_max-klemplaat_verdieping
                : hout_buiten_x_min,
            onderklem_groef_y0,
            onderklem_frees_z0
        ])
            cube([
                klemplaat_verdieping,
                onderklem_groef_y1-onderklem_groef_y0,
                onderklem_frees_z1-onderklem_frees_z0
            ]);

        // Doorlopende freeszone vanaf de voorrand tot onder de klem.
        // Het achterste deel blijft 2 mm diep voor de metalen montageplaat.
        // Het voorste geleidedeel wordt 4 mm diep; daarin komt 2 mm kunststof,
        // zodat het geleidevlak 2 mm onder het houtoppervlak blijft.
        bovenklem_hart_z = bovenklem_hart_z_exact;
        bovenklem_uitsparing_z0 =
            bovenklem_hart_z-bovenklem_geleider_hoogte/2;

        bovenklem_klem_y0 = kast_y_voor+bovenklem_randafstand;
        bovenklem_klem_y1 = kast_y_voor+klem_basis_lengte;

        // 2 mm diepe montagezone, doorgetrokken tot exact de voorrand.
        translate([
            rechts
                ? hout_buiten_x_max-klemplaat_verdieping
                : hout_buiten_x_min,
            bovenklem_klem_y0-0.1,
            bovenklem_uitsparing_z0
        ])
            cube([
                klemplaat_verdieping,
                klem_basis_lengte+0.2,
                bovenklem_geleider_hoogte
            ]);

        // Doorlopende verdieping vanaf de metalen klem tot aan de glaslat.
        //
        // De bestaande 2 mm diepe montageverdieping wordt zonder onderbreking
        // naar voren doorgetrokken tot aan het achtervlak van de glaslat.
        // De extra 2 mm voor het kunststof L-profiel wordt later als aparte
        // diepere zone toegevoegd.
        bovenklem_geleide_y0 = kast_y_voor-0.2;
        bovenklem_geleide_lengte =
            eiken_lijst_achter_y-kast_y_voor+0.4;

        translate([
            rechts
                ? hout_buiten_x_max-bovenklem_geleidebaan_diepte
                : hout_buiten_x_min,
            bovenklem_geleide_y0,
            bovenklem_uitsparing_z0
        ])
            cube([
                bovenklem_geleidebaan_diepte,
                bovenklem_geleide_lengte,
                bovenklem_geleider_hoogte
            ]);

        // Twee pocket holes per zijwand, vanaf de binnenzijde schuin omhoog
        // de bovenplaat in. Voor en achter geplaatst voor torsiestijfheid.
        if(toon_pocketholes)
            for(y=[kast_y_voor+pockethole_randafstand_y,
                   kast_y_achter-pockethole_randafstand_y])
                translate([binnen_x,y,vrije_bovenbouw_hoogte-pockethole_randafstand_z])
                    rotate([0,richting*pockethole_hoek,0])
                        cylinder(h=pockethole_lengte,d=pockethole_diameter,center=true,$fn=32);
    }
}

// ----------------------------------------------------------------------------
// Plexiglas 840 x 360 mm, horizontaal gecentreerd en onderaan uitgelijnd.
// Het glas ligt achter de volledige eiken lijst, met EPDM tussen lijst en glas.
// ----------------------------------------------------------------------------
module plexiglas_plaat() {
    color(kleur_plexiglas)
    translate([
        plexiglas_x_min,
        plexiglas_y_voor,
        plexiglas_z_min
    ])
        cube([
            plexiglas_breedte,
            plexiglas_dikte,
            plexiglas_hoogte
        ]);
}

// ----------------------------------------------------------------------------
// Twee eenvoudige stelplaatjes boven het vaste plexiglas.
// Ze vullen de 5 mm ruimte uitsluitend aan de bovenzijde en houden het glas
// tijdens montage op zijn plaats voordat de bovenste glaslat wordt gemonteerd.
module stelplaatjes_boven() {
    x_hart = vrije_binnen_breedte/2;
    for(dx=[-stelplaat_hartafstand/2,stelplaat_hartafstand/2])
        color(kleur_stelplaat)
        translate([
            x_hart+dx-stelplaat_breedte/2,
            plexiglas_y_voor + plexiglas_dikte + 0.2,
            plexiglas_z_max
        ])
            cube([
                stelplaat_breedte,
                stelplaat_diepte,
                stelplaat_hoogte
            ]);
}

// EPDM-kader van 9 mm breed tussen de achterzijde van de eiken lijst
// en de voorzijde van het plexiglas.
// ----------------------------------------------------------------------------
module epdm_stroken() {
    epdm_x0 = plexiglas_x_min + epdm_rand_inzet;
    epdm_x1 = plexiglas_x_max - epdm_rand_inzet;
    epdm_z0 = plexiglas_z_min + epdm_rand_inzet;
    epdm_z1 = plexiglas_z_max - epdm_rand_inzet;
    epdm_y = epdm_y_achter_lijst;

    color(kleur_epdm) {
        // Linker en rechter verticale strook.
        translate([epdm_x0,epdm_y,epdm_z0])
            cube([epdm_strook_breedte,epdm_dikte,epdm_z1-epdm_z0]);
        translate([epdm_x1-epdm_strook_breedte,epdm_y,epdm_z0])
            cube([epdm_strook_breedte,epdm_dikte,epdm_z1-epdm_z0]);

        // Onder- en bovenstrook tussen de verticale stroken.
        translate([epdm_x0+epdm_strook_breedte,epdm_y,epdm_z0])
            cube([epdm_x1-epdm_x0-2*epdm_strook_breedte,epdm_dikte,epdm_strook_breedte]);
        translate([epdm_x0+epdm_strook_breedte,epdm_y,epdm_z1-epdm_strook_breedte])
            cube([epdm_x1-epdm_x0-2*epdm_strook_breedte,epdm_dikte,epdm_strook_breedte]);
    }
}

// ----------------------------------------------------------------------------
// Eiken voorlijst.
// Belangrijk: de getekende schuine vorm is een BOVENAANZICHT van het
// profiel van de verticale zijstijlen. Het is dus geen schuine hoekverbinding
// in vooraanzicht.
//
// Daarom:
// - de zijstijlen behouden hun geprofileerde doorsnede in X/Y;
// - de onder- en bovenregel zijn recht;
// - de hoeken zijn eenvoudige stompe aansluitingen;
// - er worden geen diagonale happen uit de onderhoeken gezaagd.
// ----------------------------------------------------------------------------
module eiken_lijst_onder() {
    // De onderregel gebruikt hetzelfde profielprincipe als de zijstijlen,
    // maar dan 90 graden gedraaid in het Y/Z-vlak:
    // - aan de plexiglaskant eerst een rechte lip;
    // - daarna een schuine terugloop richting de voorzijde;
    // - een rechte onderzijde;
    // - de regel blijft tussen de zijstijlen, zonder overlap.
    regel_x_min = eiken_lijst_opening_x_min;
    regel_x_max = eiken_lijst_opening_x_max;

    y_achter = eiken_lijst_achter_y; // volledige 19 mm eikendikte
    // De zichtlip eindigt vlak vóór de EPDM-strook. Het glas en EPDM liggen
    // daardoor opgesloten tussen de lijst en het houten frame.
    y_lip = eiken_lijst_lip_y;
    y_voor = eiken_lijst_voor_y;

    z_onder = eiken_lijst_buiten_z_min;
    z_glaskant = eiken_lijst_opening_z_min;
    z_schuin_voor = z_glaskant - eiken_profiel_schuinte;

    // Doorsnede in Y/Z. De bovenrand aan de glaszijde is gelijk aan het
    // profiel van de verticale stijlen: rechte overlaplip, daarna schuin.
    profiel_yz = [
        [y_achter, z_onder],
        [y_voor,   z_onder],
        [y_voor,   z_schuin_voor],
        [y_lip,    z_glaskant],
        [y_achter, z_glaskant]
    ];

    color(kleur_eiken)
    difference() {
        union() {
            // Hoofddeel van de onderregel: profiel in Y/Z, geëxtrudeerd in X.
            // Lokale polygon-X wordt wereld-Y, lokale polygon-Y wordt wereld-Z
            // en de extrusierichting wordt wereld-X.
            multmatrix([
                [0,0,1,regel_x_min],
                [1,0,0,0],
                [0,1,0,0],
                [0,0,0,1]
            ])
                linear_extrude(
                    height=regel_x_max-regel_x_min,
                    convexity=10
                )
                    polygon(points=[for (p=profiel_yz) [p[0],p[1]]]);

            // Geïntegreerde eindstukjes links en rechts. De driehoekige
            // voetafdruk vult de kier tegen de verticale stijlen. Door deze
            // voetafdruk te snijden met exact hetzelfde Y/Z-profiel als de
            // onderregel loopt ook het schuine bovenvlak zonder knik door.
            intersection() {
                translate([0,0,z_onder])
                    linear_extrude(height=z_glaskant-z_onder, convexity=10)
                        polygon(points=[
                            [regel_x_min, y_lip],
                            [regel_x_min, y_voor],
                            [regel_x_min-eiken_profiel_schuinte, y_voor]
                        ]);

                multmatrix([
                    [0,0,1,regel_x_min-eiken_profiel_schuinte],
                    [1,0,0,0],
                    [0,1,0,0],
                    [0,0,0,1]
                ])
                    linear_extrude(
                        height=eiken_profiel_schuinte,
                        convexity=10
                    )
                        polygon(points=[for (p=profiel_yz) [p[0],p[1]]]);
            }

            intersection() {
                translate([0,0,z_onder])
                    linear_extrude(height=z_glaskant-z_onder, convexity=10)
                        polygon(points=[
                            [regel_x_max, y_lip],
                            [regel_x_max+eiken_profiel_schuinte, y_voor],
                            [regel_x_max, y_voor]
                        ]);

                multmatrix([
                    [0,0,1,regel_x_max],
                    [1,0,0,0],
                    [0,1,0,0],
                    [0,0,0,1]
                ])
                    linear_extrude(
                        height=eiken_profiel_schuinte,
                        convexity=10
                    )
                        polygon(points=[for (p=profiel_yz) [p[0],p[1]]]);
            }
        }

        // Sponning aan de achterzijde voor de rand van de tussenbodem.
        // De regel blijft uit 19 mm dik eiken bestaan; de laatste 7 mm wordt
        // lokaal uitgefreesd en volledig gevuld door de onverlengde tussenbodem.
        translate([
            regel_x_min-0.5,
            y_achter-eiken_uitham_diepte,
            tussenbodem_onder_z-eiken_uitham_speling
        ])
            cube([
                regel_x_max-regel_x_min+1,
                eiken_uitham_diepte,
                tussenbodem_dikte+2*eiken_uitham_speling
            ]);
    }
}

// Geprofileerde bovenregel tussen de twee zijstijlen.
// Het profiel is hetzelfde principe als de onderregel, maar verticaal gespiegeld:
// - aan de plexiglaskant eerst een rechte overlaplip;
// - daarna een schuine terugloop richting de voorzijde;
// - de bovenzijde sluit vlak aan tegen de onderzijde van de dakplaat.
module eiken_lijst_boven() {
    regel_x_min = eiken_lijst_opening_x_min;
    regel_x_max = eiken_lijst_opening_x_max;

    y_achter = eiken_lijst_achter_y; // volledige 19 mm eikendikte
    y_lip = eiken_lijst_lip_y;
    y_voor = eiken_lijst_voor_y;

    z_glaskant = eiken_lijst_opening_z_max;
    z_schuin_voor = z_glaskant + eiken_profiel_schuinte;
    z_onderkant_bovenplaat = vrije_bovenbouw_hoogte;

    // Het zichtbare deel is hetzelfde vijfpuntsprofiel als de onderregel,
    // maar verticaal gespiegeld. De 5 mm groef verandert dit profiel niet.
    profiel_yz = [
        [y_achter, z_onderkant_bovenplaat],
        [y_voor,   z_onderkant_bovenplaat],
        [y_voor,   z_schuin_voor],
        [y_lip,    z_glaskant],
        [y_achter, z_glaskant]
    ];

    color(kleur_eiken)
    union() {
        // Zichtbaar hoofdprofiel tussen de verticale zijlatten.
        multmatrix([
            [0,0,1,regel_x_min],
            [1,0,0,0],
            [0,1,0,0],
            [0,0,0,1]
        ])
            linear_extrude(
                height=regel_x_max-regel_x_min,
                convexity=10
            )
                polygon(points=[for (p=profiel_yz) [p[0],p[1]]]);

        // Geïntegreerde eindstukjes links en rechts, gelijk aan de oplossing
        // van de onderregel maar verticaal gespiegeld. Ze vullen het kleine
        // overgangspunt tegen de verticale stijlen en laten het schuine
        // zichtvlak zonder knik doorlopen.
        intersection() {
            translate([0,0,z_glaskant])
                linear_extrude(
                    height=z_onderkant_bovenplaat-z_glaskant,
                    convexity=10
                )
                    polygon(points=[
                        [regel_x_min, y_lip],
                        [regel_x_min-eiken_profiel_schuinte, y_voor],
                        [regel_x_min, y_voor]
                    ]);

            multmatrix([
                [0,0,1,regel_x_min-eiken_profiel_schuinte],
                [1,0,0,0],
                [0,1,0,0],
                [0,0,0,1]
            ])
                linear_extrude(
                    height=eiken_profiel_schuinte,
                    convexity=10
                )
                    polygon(points=[for (p=profiel_yz) [p[0],p[1]]]);
        }

        intersection() {
            translate([0,0,z_glaskant])
                linear_extrude(
                    height=z_onderkant_bovenplaat-z_glaskant,
                    convexity=10
                )
                    polygon(points=[
                        [regel_x_max, y_lip],
                        [regel_x_max, y_voor],
                        [regel_x_max+eiken_profiel_schuinte, y_voor]
                    ]);

            multmatrix([
                [0,0,1,regel_x_max],
                [1,0,0,0],
                [0,1,0,0],
                [0,0,0,1]
            ])
                linear_extrude(
                    height=eiken_profiel_schuinte,
                    convexity=10
                )
                    polygon(points=[for (p=profiel_yz) [p[0],p[1]]]);
        }

        // Eenvoudige rechte tong van 5 mm hoog in de bovenplaat.
        translate([
            regel_x_min,
            y_voor,
            z_onderkant_bovenplaat
        ])
            cube([
                regel_x_max-regel_x_min,
                y_achter-y_voor,
                eiken_boven_groef_diepte
            ]);
    }
}

// Geprofileerde verticale zijstijl volgens het BOVENAANZICHT.
//
// Aan de plexiglaskant zit de zichtbare schuine hoek:
// - achteraan blijft de 7 mm overlap tot aan de zichtopening staan;
// - vanaf de rechte glaslip loopt de rand schuin naar buiten richting voorzijde;
// - aan de achterzijde wordt een echte sponning voor de 15 mm zijwand uitgehaald.
//
// De stijl is één doorlopend onderdeel. De horizontale regels eindigen tegen
// de binnenrand van deze stijl en overlappen hem dus niet.
// ----------------------------------------------------------------------------
// Kunststof L-beschermprofiel in de vierkante zaagsnede.
//
// De zaagsnede is 7 mm diep. De kunststof achterwand is 2 mm dik,
// zodat 5 mm netto vrije ruimte overblijft voor de metalen beugel.
// De zijflens wordt met twee schroeven vanaf de zijkant vastgezet.
// ----------------------------------------------------------------------------
module glaslat_beschermhoekprofiel(
    rechts=false,
    glaslat_x_min=0,
    glaslat_x_max=0,
    y_voor=0,
    z0=0
) {
    t = glaslat_beschermprofiel_dikte;
    h = glaslat_inkeping_hoogte;

    zijwand_x =
        rechts ? hout_buiten_x_max : hout_buiten_x_min;

    // Het zicht-/glijvlak ligt 2 mm verdiept ten opzichte van het hout.
    glijvlak_x =
        rechts
        ? zijwand_x-bovenklem_geleider_netto_verdieping
        : zijwand_x+bovenklem_geleider_netto_verdieping;

    // De geleidepoot ligt volledig achter dit glijvlak.
    zijpoot_x0 =
        rechts ? glijvlak_x-t : glijvlak_x;

    overgang_overlap_y = 0.3;

    // Y-lijn waarop de poot tegen de glaslat ligt.
    voorpoot_y0 =
        y_voor+glaslat_inkeping_diepte-t;

    // Beide L-poten beginnen nu exact op dezelfde hoeklijn.
    // Hierdoor steekt de geleidepoot niet meer los vóór de glaslatpoot uit.
    zijpoot_y0 = voorpoot_y0;
    // The guide must cover the complete 30 mm side-clamp section plus
    // approximately 10 mm beyond the wooden edge.
    zijpoot_l =
        bovenklem_geleider_lengte_y;

    zijpoot_y1 =
        zijpoot_y0+zijpoot_l;

    // Gedeelde hoeklijn van beide poten.
    //
    // De poot over de glaslat eindigt exact tegen de geleidepoot.
    // Daardoor ontstaat geen derde, opstaande strook bij de aansluiting.
    hoek_x =
        rechts ? zijpoot_x0+t : zijpoot_x0;

    voorpoot_x0 =
        rechts
        ? glaslat_x_min
        : hoek_x;

    voorpoot_x1 =
        rechts
        ? hoek_x
        : glaslat_x_max;

    voorpoot_breedte =
        max(0.1,voorpoot_x1-voorpoot_x0);

    color(kleur_glaslat_beschermprofiel)
    difference() {
        union() {
            // Poot over de glaslat.
            translate([
                voorpoot_x0,
                voorpoot_y0,
                z0
            ])
                cube([
                    voorpoot_breedte,
                    t,
                    h
                ]);

            // Geleidepoot langs de zijwand.
            translate([
                zijpoot_x0,
                zijpoot_y0,
                z0
            ])
                cube([
                    t,
                    zijpoot_l,
                    h
                ]);
        }

        // Twee kleine schroefgaten door de geleidepoot.
        for(zgat=glaslat_beschermprofiel_gat_z)
            translate([
                rechts
                    ? zijpoot_x0+t+0.2
                    : zijpoot_x0-0.2,
                zijpoot_y0+zijpoot_l/2,
                z0+zgat
            ])
                rotate([0,rechts ? -90 : 90,0])
                    cylinder(
                        d=glaslat_beschermprofiel_schroef_d,
                        h=t+0.4,
                        $fn=36
                    );
    }
}


module eiken_lijst_zijstijl(rechts=false,include_beschermprofiel=true) {
    buiten_x = rechts ? eiken_lijst_buiten_x_max : eiken_lijst_buiten_x_min;
    binnen_x = rechts ? eiken_lijst_opening_x_max : eiken_lijst_opening_x_min;

    y_achter = eiken_lijst_achter_y;
    // De zichtlip eindigt vlak vóór de EPDM-strook. Het glas en EPDM liggen
    // daardoor opgesloten tussen de lijst en het houten frame.
    y_lip = eiken_lijst_lip_y;
    y_voor = eiken_lijst_voor_y;

    // Voorste einde van de schuine glaszijde. Naar buiten gericht, zodat de
    // afschuining vanaf het plexiglas duidelijk zichtbaar is.
    schuin_voor_x = rechts
        ? binnen_x + eiken_profiel_schuinte
        : binnen_x - eiken_profiel_schuinte;

    // Eerst een gesloten basisprofiel met de schuine rand aan de GLASZIJDE.
    // Aan de binnenrand eindigt het eiken direct op de EPDM/glaslip.
    // Er loopt dus geen eiken strook achter of naast de glasrand door.
    // Exact hetzelfde vijfpunts-profiel als de onderste glaslat, maar
    // 90 graden gedraaid in het bovenaanzicht. De extra rechte achterrand
    // tussen buiten_x en binnen_x vormt het duidelijke uitsteeksel naar
    // achteren; daarna volgen de rechte glaslip en één schuine zichtzijde.
    profiel_punten = rechts
        ? [
            [buiten_x,      y_achter],
            [binnen_x,      y_achter],
            [binnen_x,      y_lip],
            [schuin_voor_x, y_voor],
            [buiten_x,      y_voor]
          ]
        : [
            [buiten_x,      y_achter],
            [buiten_x,      y_voor],
            [schuin_voor_x, y_voor],
            [binnen_x,      y_lip],
            [binnen_x,      y_achter]
          ];

    // Exacte positie van de 15 mm houten zijwand.
    wand_x_min = rechts ? vrije_binnen_breedte : hout_buiten_x_min;
    wand_x_max = rechts ? hout_buiten_x_max : 0;

    // Gedeelde maten voor zowel de zaagsnede als het kunststof profiel.
    // Deze staan bewust op module-niveau en dus buiten difference().
    glaslat_inkeping_z0 =
        bovenklem_hart_z_exact-glaslat_inkeping_hoogte/2;

    glaslat_x_min = min(
        buiten_x,
        min(binnen_x,schuin_voor_x)
    );

    glaslat_x_max = max(
        buiten_x,
        max(binnen_x,schuin_voor_x)
    );

    color(kleur_eiken)
    difference() {
        // De verticale zijlijst loopt vanaf de bovenzijde van de verlengde
        // onderplaat tot strak tegen de onderzijde van de dakplaat.
        // De tussenbodem wordt lokaal uitgefreesd; de bovenplaat blijft heel.
        translate([0,0,eiken_zijstijl_z_min])
            linear_extrude(
                height=vrije_bovenbouw_hoogte-eiken_zijstijl_z_min,
                convexity=10
            )
                polygon(points=profiel_punten);

        // Centrale groef voor de 5 x 5 mm multiplex tong.
        // Groefbreedte 5,3 mm geeft 0,3 mm montagespeling.
        // Groefdiepte 5,2 mm geeft 0,2 mm bodemspeling.
        tong_hart_x =
            (wand_x_min+wand_x_max)/2;

        translate([
            tong_hart_x-eiken_tonggroef_breedte/2,
            kast_y_voor,
            eiken_zijstijl_z_min-0.5
        ])
            cube([
                eiken_tonggroef_breedte,
                eiken_tonggroef_diepte,
                vrije_bovenbouw_hoogte-eiken_zijstijl_z_min+0.5
            ]);

        // Volledige 5 mm vrijloop in de eiken glaslijst.
        //
        // Het verhoogde deel van de klem loopt over een langere strook langs
        // de glaslat. Daarom wordt de glaslat over de volledige klemzone
        // verdiept, niet alleen lokaal bij het scharnier.
        bovenklem_hart_z = bovenklem_hart_z_exact;

        bovenklem_vrijloop_z0 =
            bovenklem_hart_z-bovenklem_uitsparing_hoogte_z/2;

        bovenklem_vrijloop_y0 =
            kast_y_voor-bovenklem_uitsparing_speling_voor_y;

        // Rechthoekige inkeping in het VOORVLAK van de eiken glaslat:
        // - 5 mm diep in Y, vanaf y_voor naar achteren;
        // - 50 mm hoog in Z;
        // - over de volledige breedte van deze glaslat in X.
        //
        // Dit is de groene zone uit de schets: de volledige stijl wordt lokaal
        // 5 mm teruggenomen, zodat de inkeping duidelijk zichtbaar is.
        // Zaagbewerking 1, vanaf de VOORKANT van de glaslat:
        // - 7 mm diep in Y;
        // - 50 mm hoog;
        // - over de volledige breedte van de glaslat in X.
        translate([
            glaslat_x_min-0.2,
            y_voor-0.2,
            glaslat_inkeping_z0
        ])
            cube([
                glaslat_x_max-glaslat_x_min+0.4,
                glaslat_inkeping_diepte+0.2,
                glaslat_inkeping_hoogte
            ]);

        // De 4 mm diepe zijbaan wordt ook door de glaslat getrokken.
        // Zo ontstaat één ononderbroken baan voor de 2 mm kunststof
        // geleidepoot, zonder opstaande rand bij de overgang.
        translate([
            rechts
                ? hout_buiten_x_max-bovenklem_geleidebaan_diepte
                : hout_buiten_x_min,
            y_voor-0.2,
            glaslat_inkeping_z0
        ])
            cube([
                bovenklem_geleidebaan_diepte,
                y_achter-y_voor+0.4,
                glaslat_inkeping_hoogte
            ]);

    }
    if(
        include_beschermprofiel
        && toon_glaslat_beschermprofielen
    )
        glaslat_beschermhoekprofiel(
            rechts,
            glaslat_x_min,
            glaslat_x_max,
            y_voor,
            glaslat_inkeping_z0
        );

}

module eiken_lijst_links(include_beschermprofiel=true) {
    eiken_lijst_zijstijl(false,include_beschermprofiel);
}

module eiken_lijst_rechts(include_beschermprofiel=true) {
    eiken_lijst_zijstijl(true,include_beschermprofiel);
}

module eiken_lijst(
    exploded=false,
    include_beschermprofiel=true
) {
    translate([exploded ? -eiken_deel_explode_x : 0,0,0])
        eiken_lijst_links(include_beschermprofiel);
    translate([exploded ? eiken_deel_explode_x : 0,0,0])
        eiken_lijst_rechts(include_beschermprofiel);
    translate([0,0,exploded ? -eiken_deel_explode_z : 0])
        eiken_lijst_onder();
    translate([0,0,exploded ? eiken_deel_explode_z : 0])
        eiken_lijst_boven();
}


// ----------------------------------------------------------------------------
// Houten bovenplaat, links en rechts 16 mm verlengd voor de bovenhoekgrepen.
// Alleen de opening en montagegaten voor de handgreep blijven aanwezig.
// ----------------------------------------------------------------------------

module v11_bovenkap_profiel_2d() {
    kap_x0 = hout_buiten_x_min-bovenkap_overlengte_per_zijde;
    kap_x1 = hout_buiten_x_max+bovenkap_overlengte_per_zijde;
    kap_y0 = kast_y_voor-bovenkap_overstek_voor;

    rear_end_y = kast_y_voor+v11_upper_end_depth;
    rear_center_y = kast_y_voor+v11_upper_center_depth;
    r = v11_upper_transition_radius;

    // 30 mm straight end zone is referenced from the actual plywood side
    // wall, not from the decorative top overhang.
    //
    // The transition must be a true concave R20 cut, matching the side-wall
    // language.  The radius centres are therefore on the 80 mm rear line,
    // one radius inward from the end of each straight zone.
    left_straight_x = hout_buiten_x_min+v11_top_end_straight_width;
    left_center_x = left_straight_x+r;
    right_straight_x = hout_buiten_x_max-v11_top_end_straight_width;
    right_center_x = right_straight_x-r;

    steps = 16;

    // Left concave transition: (straight_x, 80 mm) ->
    // (straight_x + R20, 60 mm).
    left_arc = [
        for(i=[0:steps])
            let(a=180+90*i/steps)
                [
                    left_center_x + r*cos(a),
                    rear_end_y + r*sin(a)
                ]
    ];

    // Right concave transition: (straight_x - R20, 60 mm) ->
    // (straight_x, 80 mm).
    right_arc = [
        for(i=[0:steps])
            let(a=270+90*i/steps)
                [
                    right_center_x + r*cos(a),
                    rear_end_y + r*sin(a)
                ]
    ];

    polygon(points=concat(
        [
            [kap_x0,kap_y0],
            [kap_x1,kap_y0],
            [kap_x1,rear_end_y],
            [right_straight_x,rear_end_y]
        ],
        [for(i=[steps:-1:0]) right_arc[i]],
        [[left_straight_x+r,rear_center_y]],
        [for(i=[steps:-1:0]) left_arc[i]],
        [[kap_x0,rear_end_y]]
    ));
}

module houten_bovenkap() {
    kap_x0 = hout_buiten_x_min-bovenkap_overlengte_per_zijde;
    kap_y0 = kast_y_voor-bovenkap_overstek_voor;
    bovenkap_achter_y = kast_y_achter+bovenkap_overstek_achter;

    color(kleur_hout_kop)
    difference() {
        // V1.1 shaped top panel. The front overhang remains unchanged while
        // the rear edge follows the slimmer upper side-wall profile.
        translate([0,0,vrije_bovenbouw_hoogte])
            linear_extrude(height=hout_dikte)
                v11_bovenkap_profiel_2d();

        // Lokale groef voor de bovenste eiken glaslat.
        // De groef is 5 mm diep, loopt alleen tussen de verticale zijlijsten
        // en stopt dus ruim vóór de linker- en rechtereinden van de dakplaat.
        translate([
            eiken_lijst_opening_x_min-eiken_boven_groef_speling+eiken_boven_groef_eindspeling,
            eiken_lijst_voor_y-eiken_boven_groef_speling,
            vrije_bovenbouw_hoogte-0.01
        ])
            cube([
                (eiken_lijst_opening_x_max-eiken_lijst_opening_x_min)
                    +2*eiken_boven_groef_speling-2*eiken_boven_groef_eindspeling,
                (kast_y_voor-eiken_lijst_voor_y)+2*eiken_boven_groef_speling,
                eiken_boven_groef_diepte+0.02
            ]);
    }
}

// ----------------------------------------------------------------------------
// Tussenbodem. Alleen schotgroeven blijven behouden.
// Groeven voor aluminium/glas en kabeldoorvoeren zijn verwijderd.
// De plaat heeft exact dezelfde diepte als de houten zijwanden: 88 mm.
// ----------------------------------------------------------------------------
module houten_tussenbodem() {
    color(kleur_hout)
    difference() {
        translate([
            -tussenbodem_zijgroef_diepte,
            kast_y_voor,
            tussenbodem_onder_z
        ])
            cube([
                vrije_binnen_breedte + 2*tussenbodem_zijgroef_diepte,
                kast_diepte,
                tussenbodem_dikte
            ]);

        // Kleine profieluitsparingen aan de voorhoeken. Hierdoor kunnen de
        // verticale eiken zijlijsten als één lang onderdeel door de
        // tussenbodem lopen. De bovenplaat blijft volledig intact.
        for(rechts=[false,true]) {
            buiten_x = rechts ? eiken_lijst_buiten_x_max : eiken_lijst_buiten_x_min;
            binnen_x = rechts ? eiken_lijst_opening_x_max : eiken_lijst_opening_x_min;
            y_achter = eiken_lijst_achter_y;
            y_lip = eiken_lijst_lip_y;
            y_voor = eiken_lijst_voor_y;
            schuin_voor_x = rechts
                ? binnen_x + eiken_profiel_schuinte
                : binnen_x - eiken_profiel_schuinte;
            profiel_punten = rechts
                ? [
                    [buiten_x, y_achter],
                    [buiten_x, y_voor],
                    [schuin_voor_x, y_voor],
                    [binnen_x, y_lip],
                    [binnen_x, y_achter]
                  ]
                : [
                    [buiten_x, y_achter],
                    [binnen_x, y_achter],
                    [binnen_x, y_lip],
                    [schuin_voor_x, y_voor],
                    [buiten_x, y_voor]
                  ];

            translate([0,0,tussenbodem_onder_z-0.1])
                linear_extrude(height=tussenbodem_dikte+0.2,convexity=10)
                    offset(delta=eiken_boven_groef_speling)
                        polygon(points=profiel_punten);
        }

        for(x=[ondervak_schot_x1,ondervak_schot_x2])
            translate([
                x-(ondervak_schot_dikte+ondervak_groef_speling)/2,
                ondervak_schot_y_min,
                tussenbodem_onder_z-0.1
            ])
                cube([
                    ondervak_schot_dikte+ondervak_groef_speling,
                    ondervak_schot_diepte,
                    ondervak_groef_diepte+0.2
                ]);

        // Pocket holes vanaf de bovenzijde van de tussenbodem naar de zijwanden.
        // Net als bij de bovenste zijwandverbinding gebruiken we één eenvoudige,
        // gecentreerde cilindrische pocket. Hierdoor ontstaat geen uitstekende
        // halve cilinder of losse boutvorm boven op de plank.
        if(toon_pocketholes)
            for(rechts=[false,true])
                for(y=[kast_y_voor+pockethole_randafstand_y,
                       kast_y_achter-pockethole_randafstand_y]) {
                    x = rechts ? vrije_binnen_breedte-pockethole_plaat_randafstand_x
                               : pockethole_plaat_randafstand_x;
                    hoek = rechts ? 90+pockethole_hoek : -(90+pockethole_hoek);
                    translate([x,y,tussenbodem_boven_z-1.5])
                        rotate([0,hoek,0])
                            cylinder(
                                h=pockethole_lengte,
                                d=pockethole_diameter,
                                center=true,
                                $fn=32
                            );
                }
    }
}

// ----------------------------------------------------------------------------
// Pocket-hole uitsparing: brede verzonken pocket met smallere pilotboring.
// De lokale +Z-as is de schroefrichting.
// ----------------------------------------------------------------------------
module pocketgat_vorm(
    lengte=pockethole_lengte,
    pocket_d=pockethole_diameter,
    pilot_d=pockethole_pilot_diameter,
    pocket_lengte=12
) {
    // Eén ononderbroken uitsparing. De brede toegang loopt via een korte
    // conische overgang over in de pilotboring; zo ontstaat intern geen rand.
    overgang = min(3, max(1, pocket_lengte/3));
    rechte_pocket = max(0.2, pocket_lengte-overgang);
    pilot_lengte = max(0.2, lengte-pocket_lengte);

    union() {
        cylinder(h=rechte_pocket+0.05,d=pocket_d,$fn=32);
        translate([0,0,rechte_pocket])
            cylinder(h=overgang+0.1,d1=pocket_d,d2=pilot_d,$fn=32);
        translate([0,0,pocket_lengte-0.05])
            cylinder(h=pilot_lengte+0.1,d=pilot_d,$fn=24);
    }
}


// ----------------------------------------------------------------------------
// Pocket hole voor een middelstaander.
// De zichtbare opening wordt vanaf de buitenzijde door de 15 mm staander
// gesneden. Vanaf de bovenzijde van die pocket loopt de pilotboring verticaal
// omhoog naar de tussenbodem. Dit voorkomt de losse cilindervorm die in de
// vorige varianten zichtbaar was.
// ----------------------------------------------------------------------------
module staander_pocketgat_uniform(x_hart, y_pos) {
    // Exact dezelfde cilindrische pocket-holevorm als bij de bovenplaat en
    // tussenbodem. Alleen positie en spiegeling verschillen.
    linker_staander = x_hart < vrije_binnen_breedte/2;
    x_buitenzijde = linker_staander
        ? x_hart-ondervak_schot_dikte/2
        : x_hart+ondervak_schot_dikte/2;
    richting = linker_staander ? 1 : -1;

    // De as loopt vanaf de buitenzijde schuin naar binnen en omhoog naar de
    // onderzijde van de tussenbodem. Door center=true ontstaat aan het vlak
    // dezelfde ovale pocket als bij de overige verbindingen.
    translate([x_buitenzijde,y_pos,tussenbodem_onder_z-pockethole_randafstand_z])
        rotate([0,richting*pockethole_hoek,0])
            cylinder(
                h=pockethole_lengte,
                d=pockethole_diameter,
                center=true,
                $fn=32
            );
}

// ----------------------------------------------------------------------------
// Verlengde onderbodem met schotgroeven en spanbandsleuven.
// De voorrand ligt gelijk met de voorzijde van de eiken lijst.
// ----------------------------------------------------------------------------
module houten_onderbodem() {
    color(kleur_hout)
    difference() {
        translate([
            hout_buiten_x_min,
            onderbodem_y_min,
            onderbodem_onder_z
        ])
            cube([
                hout_buiten_breedte,
                onderbodem_diepte_verlengd,
                onderbodem_dikte
            ]);

        for(x=[ondervak_schot_x1,ondervak_schot_x2])
            translate([
                x-(ondervak_schot_dikte+ondervak_groef_speling)/2,
                ondervak_schot_y_min,
                ondervak_onder_z-ondervak_groef_diepte
            ])
                cube([
                    ondervak_schot_dikte+ondervak_groef_speling,
                    ondervak_schot_diepte,
                    ondervak_groef_diepte+0.2
                ]);

        for(x=[hout_buiten_x_min+170,hout_buiten_x_max-170])
            translate([
                x-22,
                kast_y_voor+35,
                onderbodem_onder_z-1
            ])
                cube([44,14,onderbodem_dikte+2]);

        // Deel B van de doorlopende groef in de kopse kant van de onderplank.
        // De groef staat exact achter de onderste sluiting en loopt door
        // de volledige dikte van de plank.
        // Linker kopse kant.
        translate([
            hout_buiten_x_min-0.1,
            onderklem_groef_y0,
            onderbodem_onder_z-0.1
        ])
            cube([
                klemplaat_verdieping+0.2,
                onderklem_groef_y1-onderklem_groef_y0,
                onderbodem_dikte+0.2
            ]);

        // Rechter kopse kant.
        translate([
            hout_buiten_x_max-klemplaat_verdieping-0.1,
            onderklem_groef_y0,
            onderbodem_onder_z-0.1
        ])
            cube([
                klemplaat_verdieping+0.2,
                onderklem_groef_y1-onderklem_groef_y0,
                onderbodem_dikte+0.2
            ]);

    }
}

// ----------------------------------------------------------------------------
// Twee uitneembare schotten voor het onderste opbergvak.
// Ze zijn naar voren verlengd tot dezelfde rand als de onderbodem.
// ----------------------------------------------------------------------------
module houten_ondervak_schot(x_hart) {
    color(kleur_hout_kop)
    difference() {
        union() {
            // Hoofddeel tussen de bovenkant van de onderbodem en de onderkant
            // van de tussenbodem.
            translate([
                x_hart-ondervak_schot_dikte/2,
                ondervak_schot_y_min,
                ondervak_onder_z
            ])
                cube([
                    ondervak_schot_dikte,
                    ondervak_schot_diepte,
                    ondervak_inwendig_hoogte
                ]);

            // Onderste 3 mm lip in de groef van de onderbodem.
            translate([
                x_hart-ondervak_schot_dikte/2,
                ondervak_schot_y_min,
                ondervak_onder_z-ondervak_groef_diepte
            ])
                cube([
                    ondervak_schot_dikte,
                    ondervak_schot_diepte,
                    ondervak_groef_diepte
                ]);

            // Bovenste 3 mm tong loopt over de volledige diepte door en valt
            // in de doorlopende groef aan de onderzijde van de tussenbodem.
            translate([
                x_hart-ondervak_schot_dikte/2,
                ondervak_schot_y_min,
                tussenbodem_onder_z
            ])
                cube([
                    ondervak_schot_dikte,
                    ondervak_schot_diepte,
                    ondervak_groef_diepte
                ]);
        }

        // Alleen pocket holes van de staanders naar de middelste plaat.
        // De opening zit aan de buitenzijde; de pilotboring en schroef lopen
        // verticaal omhoog in de middelste horizontale plaat.
        if(toon_pocketholes)
            for(voorkant=[true,false]) {
                y = voorkant
                    ? ondervak_schot_y_min+pockethole_randafstand_y
                    : kast_y_achter-pockethole_randafstand_y;
                staander_pocketgat_uniform(x_hart,y);
            }
    }
}

// ----------------------------------------------------------------------------
// Volledige afneembare houten voorplaat.
// ----------------------------------------------------------------------------
module houten_voorpaneel() {
    // De oude zes montagegaten zijn verwijderd.
    color(kleur_hout_kop)
    translate([
        hout_buiten_x_min,
        kast_y_voor,
        hout_buiten_z_min
    ])
        cube([
            hout_buiten_breedte,
            voorpaneel_hout_dikte,
            hout_buiten_hoogte
        ]);
}

// Rear-panel geometry is implemented in components/rear_panel.scad.

// ----------------------------------------------------------------------------
// Vereenvoudigde visualisatie van montageschroeven in de pocket-holevariant.
// ----------------------------------------------------------------------------
module schroef_langs_z(lengte=montageschroef_lengte) {
    color([0.55,0.57,0.60,1]) {
        cylinder(h=lengte,d=montageschroef_d,$fn=24);
        cylinder(h=montageschroef_kophoogte,d=montageschroef_kop_d,$fn=32);
    }
}

module montageschroeven() {
    // Zijwanden naar bovenplaat.
    for(rechts=[false,true])
        for(y=[kast_y_voor+pockethole_randafstand_y,
               kast_y_achter-pockethole_randafstand_y]) {
            x = rechts ? vrije_binnen_breedte : 0;
            richting = rechts ? 1 : -1;
            translate([x,y,vrije_bovenbouw_hoogte-pockethole_randafstand_z])
                rotate([0,richting*pockethole_hoek,0])
                    schroef_langs_z();
        }

    // Tussenbodem naar zijwanden. De schroefkop ligt verzonken in de pocket
    // en steekt niet boven het plaatvlak uit.
    for(rechts=[false,true])
        for(y=[kast_y_voor+pockethole_randafstand_y,
               kast_y_achter-pockethole_randafstand_y]) {
            x = rechts ? vrije_binnen_breedte-pockethole_plaat_randafstand_x
                       : pockethole_plaat_randafstand_x;
            hoek = rechts ? 90+pockethole_hoek : -(90+pockethole_hoek);
            translate([x,y,tussenbodem_boven_z-1.5])
                rotate([0,hoek,0])
                    translate([0,0,5])
                        schroef_langs_z();
        }

    // Onderbodem-zijwandverbinding is in deze variant nog niet gemodelleerd.

    // Alleen schroeven van de staanders naar de tussenbodem.
    // Ze volgen exact dezelfde schuine richting als de pocket holes.
    for(x=[ondervak_schot_x1,ondervak_schot_x2])
        for(voorkant=[true,false]) {
            linker_staander = x < vrije_binnen_breedte/2;
            y = voorkant
                ? ondervak_schot_y_min+pockethole_randafstand_y
                : kast_y_achter-pockethole_randafstand_y;
            x_buitenzijde = linker_staander
                ? x-ondervak_schot_dikte/2
                : x+ondervak_schot_dikte/2;
            richting = linker_staander ? 1 : -1;
            translate([x_buitenzijde,y,tussenbodem_onder_z-pockethole_randafstand_z])
                rotate([0,richting*pockethole_hoek,0])
                    translate([0,0,5])
                        schroef_langs_z();
        }
}

// ----------------------------------------------------------------------------
// Twee kunststof steunvoetjes/steunlatten onder de middelste kastzone.
// De buitenste ondersteuning wordt al verzorgd door de kunststof hoekbeugels.
// ----------------------------------------------------------------------------
module kunststof_middenvoetje(x_hart=0) {
    color(kleur_kunststof_middenvoet)
    translate([
        x_hart-houten_voet_breedte/2,
        houten_voet_y_min,
        onderbodem_onder_z-houten_voet_hoogte
    ])
        cube([
            houten_voet_breedte,
            houten_voet_diepte,
            houten_voet_hoogte
        ]);
}

module houten_voetjes() {
    // Naam behouden om bestaande assemblage-aanroepen niet te breken.
    // De twee resterende onderdelen zijn nu echter kunststof.
    for(i=[1,2])
        kunststof_middenvoetje(houten_voet_x_posities[i]);
}

// Geïntegreerd positioneer-eindprofiel.
//
// Dit is geen losse nok meer. Het vormt het volledige schuine uiteinde van
// de bovenflens, over de volledige X-diepte van het kunststof inzetstuk.
//
// Zijaanzicht in Y-Z:
// - eerste 1,5 mm recht omhoog;
// - daarna één schuine overgang naar de 4 mm hoge bovenflens.
//
// y_shift is 0 binnen de lokale kastassemblage en montage_kast_y_shift voor
// het inzetstuk dat rechtstreeks in de complete montageweergave staat.
module kunststof_positioneer_eindprofiel(
    rechts=false,
    voor=true,
    steun_y0=0,
    z0=0,
    speling=0
) {
    rand_x = rechts ? hout_buiten_x_max : hout_buiten_x_min;

    profiel_breedte_x =
        2*onderbeugel_schouder_breedte
        +onderbeugel_tong_breedte
        +2*speling;

    bestaand_x0 = rechts
        ? rand_x-profiel_breedte_x
        : rand_x;

    bestaand_x1 = rechts
        ? rand_x
        : rand_x+profiel_breedte_x;

    // De uitsparing loopt in X door tot aan de buitenrand van de L-steun.
    uitsparing_x0 = rechts
        ? bestaand_x0
        : rand_x-hoekbeugel_zijdikte_x-speling;

    uitsparing_x1 = rechts
        ? rand_x+hoekbeugel_zijdikte_x+speling
        : bestaand_x1;

    // The ramp length is measured in Y and remains equal to the original
    // positioning-profile length. The 10 mm bracket protrusion is in X and
    // is already covered by uitsparing_x0 / uitsparing_x1.
    profiel_lengte_y =
        kunststof_positioneer_lengte_y+2*speling;

    // v190 zat aan de verkeerde kant. Daarom wordt de lokale Y-zijde
    // hier bewust omgedraaid.
    y0 = voor
        ? steun_y0+hoekbeugel_breedte_y
            -kunststof_positioneer_lengte_y-speling
        : steun_y0-speling;

    y1 = y0+profiel_lengte_y;

    laag_z = z0;
    recht_z = z0+kunststof_positioneer_recht_z;
    hoog_z = z0+kunststof_positioneer_hoogte+speling;

    // Eén trapeziumvormige uitsnijding:
    // aan de buitenrand eerst 1,5 mm recht, daarna schuin naar de
    // volledige profielhoogte. Er is geen rechthoekige basisuitsparing.
    points_yz = voor
        ? [
            [y0,laag_z],
            [y1,laag_z],
            [y1,hoog_z],
            [y0,recht_z]
          ]
        : [
            [y0,laag_z],
            [y1,laag_z],
            [y1,recht_z],
            [y0,hoog_z]
          ];

    polyhedron(
        points=[
            [uitsparing_x0,points_yz[0][0],points_yz[0][1]],
            [uitsparing_x0,points_yz[1][0],points_yz[1][1]],
            [uitsparing_x0,points_yz[2][0],points_yz[2][1]],
            [uitsparing_x0,points_yz[3][0],points_yz[3][1]],
            [uitsparing_x1,points_yz[0][0],points_yz[0][1]],
            [uitsparing_x1,points_yz[1][0],points_yz[1][1]],
            [uitsparing_x1,points_yz[2][0],points_yz[2][1]],
            [uitsparing_x1,points_yz[3][0],points_yz[3][1]]
        ],
        faces=[
            [0,1,2,3],
            [7,6,5,4],
            [0,4,5,1],
            [1,5,6,2],
            [2,6,7,3],
            [3,7,4,0]
        ],
        convexity=10
    );
}


// ----------------------------------------------------------------------------
// Kunststof L-hoekbeugels vóór en achter de klem, links en rechts.
//
// Lokale constructie:
// - verticale poot: 10 mm dik in X, 30 mm breed in Y, 60 mm hoog;
// - horizontale voet: 40 mm naar binnen, 30 mm breed in Y, 10 mm hoog;
// - twee gewone doorlopende gaten door het zijdeel;
// - twee gewone doorlopende gaten vanaf de onderzijde.
//
// De schroefassen liggen in verschillende richtingen en posities, zodat de
// schroeven elkaar niet kruisen.
// ----------------------------------------------------------------------------
module kunststof_hoekbeugel(rechts=false,y0=houten_voet_y_min,voor=true) {
    // y0 wordt expliciet meegegeven, zodat per kastzijde één beugel vóór
    // en één beugel achter de klem kan worden geplaatst.
    z_onder = onderbodem_onder_z-hoekbeugel_voethoogte_z;

    rand_x = rechts ? hout_buiten_x_max : hout_buiten_x_min;

    x_vert = rechts
        ? rand_x
        : rand_x-hoekbeugel_zijdikte_x;

    // De horizontale poot begint onder het verticale deel en loopt daarna
    // 40 mm onder de kast door. Zo ontstaat één echte, doorlopende L-vorm.
    x_voet = rechts
        ? rand_x-hoekbeugel_voetlengte_x
        : rand_x-hoekbeugel_zijdikte_x;
    voet_lengte_x =
        hoekbeugel_voetlengte_x+hoekbeugel_zijdikte_x;

    color(kleur_hoekbeugel)
    difference() {
        union() {
            // Verticaal bescherm- en montagedeel tegen de zijwand.
            translate([x_vert,y0,z_onder])
                cube([
                    hoekbeugel_zijdikte_x,
                    hoekbeugel_breedte_y,
                    hoekbeugel_zijhoogte+hoekbeugel_voethoogte_z
                ]);

            // Horizontale voet onder de kast.
            translate([x_voet,y0,z_onder])
                cube([
                    voet_lengte_x,
                    hoekbeugel_breedte_y,
                    hoekbeugel_voethoogte_z
                ]);
        }

        // Use the exact proven v204 recess at both Y ends.
        //
        // No new wedge geometry is constructed here. The original front and
        // rear variants are both subtracted from the same printable bracket.
        kunststof_positioneer_eindprofiel(
            rechts=rechts,
            voor=true,
            steun_y0=y0,
            z0=z_onder-0.1,
            speling=kunststof_positioneer_speling
        );

        kunststof_positioneer_eindprofiel(
            rechts=rechts,
            voor=false,
            steun_y0=y0,
            z0=z_onder-0.1,
            speling=kunststof_positioneer_speling
        );

        // Twee horizontale zijschroefgaten.
        for(zlokaal=hoekbeugel_zijgat_z) {
            x_start = rechts
                ? rand_x+hoekbeugel_zijdikte_x+0.2
                : rand_x-hoekbeugel_zijdikte_x-0.2;

            translate([
                x_start,
                y0+hoekbeugel_breedte_y/2,
                z_onder+hoekbeugel_voethoogte_z+zlokaal
            ])
                rotate([0,rechts ? -90 : 90,0])
                    cylinder(
                        d=hoekbeugel_schroef_d,
                        h=hoekbeugel_zijdikte_x+0.4,
                        $fn=48
                    );

        }

        // Twee onderschroefgaten, van onder naar boven.
        for(xlokaal=hoekbeugel_ondergat_x) {
            xgat = rechts
                ? rand_x-xlokaal
                : rand_x+xlokaal;

            translate([
                xgat,
                y0+hoekbeugel_breedte_y/2,
                z_onder-0.2
            ])
                cylinder(
                    d=hoekbeugel_schroef_d,
                    h=hoekbeugel_voethoogte_z+0.4,
                    $fn=48
                );

        }
    }
}

module kunststof_hoekbeugels() {
    // In het zijaanzicht is de linker groene beugel de VOORSTE beugel.
    // Die wordt uitgelijnd met de echte voorhoek van het scherm/eiken profiel,
    // niet met de terugliggende houten zijwand.
    y_voor = eiken_lijst_voor_y;

    // Achterste beugel blijft gelijk met de achterrand van de kast.
    y_achter = kast_y_achter-hoekbeugel_breedte_y;

    // Dezelfde voor-/achterpositie aan beide fysieke kastzijden.
    for(rechts=[false,true]) {
        kunststof_hoekbeugel(rechts,y_voor,true);
        kunststof_hoekbeugel(rechts,y_achter,false);
    }
}

// Aluminium frame geometry is implemented in components/aluminium_frame.scad.

// ----------------------------------------------------------------------------
// Assemblages.
// ----------------------------------------------------------------------------
module houten_frame_assemblage(
    exploded=false,
    monteer_voorplaat=false,
    monteer_achterplaat=false,
    include_aluminium=toon_aluminium_frame,
    include_led_panelen=toon_led_panelen,
    include_acrylic=toon_plexiglas,
    include_roundwood=toon_roundwood_frame,
    include_roundwood_sockets=toon_roundwood_sockets,
    include_roundwood_cross_member=toon_roundwood_cross_member,
    include_roundwood_center_supports=toon_roundwood_center_supports
) {
    translate([exploded ? -hout_explode_x : 0,0,0])
        houten_zijwand(false);
    translate([exploded ? hout_explode_x : 0,0,0])
        houten_zijwand(true);

    if(include_acrylic)
        translate([0,exploded ? plexiglas_explode_y : 0,0])
            plexiglas_plaat();

    if(toon_stelplaatjes)
        translate([0,exploded ? stelplaat_explode_y : 0,0])
            stelplaatjes_boven();

    if(toon_epdm)
        translate([0,exploded ? epdm_explode_y : 0,0])
            epdm_stroken();

    if(toon_eiken_lijst)
        translate([0,exploded ? eiken_lijst_explode_y : 0,0])
            eiken_lijst(exploded);

    // The component is local; this assembly supplies its mounted position.
    translate([alu_frame_x_min,alu_frame_y_voor,alu_frame_z_min])
        aluminium_frame_package(
            include_aluminium,
            include_led_panelen,
            exploded ? alu_explode_y : 0,
            exploded ? led_panelen_explode_y : 0
        );

    if(toon_bovenkap)
        translate([0,0,exploded ? hout_explode_z*1.35 : 0]) {
            houten_bovenkap();
        }

    if(
        include_roundwood
        || include_roundwood_sockets
        || include_roundwood_cross_member
        || include_roundwood_center_supports
    )
        roundwood_carry_structure(
            hout_buiten_x_min,
            hout_buiten_x_max,
            kast_y_achter,
            kast_y_voor+v11_upper_center_depth,
            bovenbouw_onder_z,
            vrije_bovenbouw_hoogte,
            hout_dikte,
            hout_dikte,
            include_roundwood,
            include_roundwood_sockets,
            include_roundwood_cross_member,
            include_roundwood_center_supports,
            exploded
        );

    translate([0,0,exploded ? -hout_explode_z*0.45 : 0])
        houten_tussenbodem();

    translate([0,0,exploded ? -hout_explode_z : 0])
        houten_onderbodem();

    translate([0,0,exploded ? -hout_explode_z+voetjes_explode_z : 0]) {
        houten_voetjes();
        kunststof_hoekbeugels();
    }

    translate([
        exploded ? -hout_explode_x*0.35 : 0,
        0,
        exploded ? -hout_explode_z*0.75 : 0
    ])
        houten_ondervak_schot(ondervak_schot_x1);

    translate([
        exploded ? hout_explode_x*0.35 : 0,
        0,
        exploded ? -hout_explode_z*0.75 : 0
    ])
        houten_ondervak_schot(ondervak_schot_x2);

    if(monteer_voorplaat)
        // De plaat ligt vóór de eiken lijst, niet binnen in de kast.
        translate([
            0,
            gemonteerde_voorplaat_y-kast_y_voor,
            0
        ])
            houten_voorpaneel();

    if(monteer_achterplaat)
        translate([
            hout_buiten_x_min,
            kast_y_achter-achterpaneel_hout_dikte
                +(exploded ? achterpaneel_explode_y : 0),
            hout_buiten_z_min
        ])
            rear_panel(
                hout_buiten_breedte,
                hout_buiten_hoogte,
                achterpaneel_hout_dikte,
                "model"
            );

    if(toon_pocketholes && !exploded) {
        montageschroeven();
    }
}

// De twee uitsparingen voor de kunststof kernen.
// Alleen de kernmaat wordt uit het hout gehaald: circa 16 x 24 mm.
// De veel bredere boven- en onderflenzen liggen over het hout en worden
// nadrukkelijk NIET uit de grondplaat gesneden.
module grondplaat_inzetuitsparingen(scherm_y_hart,grondplaat_onder_z) {
    translate([
        hout_buiten_x_min-0.1,
        scherm_y_hart-kunststof_kern_lengte/2-kunststof_inzet_speling,
        grondplaat_onder_z-0.1
    ])
        cube([
            kunststof_kern_diepte+kunststof_inzet_speling+0.2,
            kunststof_kern_lengte+2*kunststof_inzet_speling,
            voorpaneel_hout_dikte+0.2
        ]);

    translate([
        hout_buiten_x_max-kunststof_kern_diepte-kunststof_inzet_speling-0.1,
        scherm_y_hart-kunststof_kern_lengte/2-kunststof_inzet_speling,
        grondplaat_onder_z-0.1
    ])
        cube([
            kunststof_kern_diepte+kunststof_inzet_speling+0.2,
            kunststof_kern_lengte+2*kunststof_inzet_speling,
            voorpaneel_hout_dikte+0.2
        ]);
}

// Voorplaat horizontaal neerleggen. Het bovenvlak van de plaat ligt exact
// op de onderzijde van de rechtopstaande houten kast.
module voorplaat_als_grondplaat(
    scherm_y_hart=onderste_klem_y_hart
) {
    grondplaat_boven_z = onderbodem_onder_z-houten_voet_hoogte;
    grondplaat_onder_z = grondplaat_boven_z-voorpaneel_hout_dikte;

    difference() {
        translate([
            0,
            hout_buiten_z_min,
            grondplaat_boven_z
        ])
            rotate([90,0,0])
                houten_voorpaneel();

        grondplaat_inzetuitsparingen(scherm_y_hart,grondplaat_onder_z);
    }
}

// Losse grondplaat/voorplaat met exact dezelfde twee kernuitsparingen als
// in de complete montageweergave. Alleen het hout wordt getoond.
module losse_voorplaat_met_inzetuitsparingen() {
    grondplaat_boven_z = 0;
    grondplaat_onder_z = -voorpaneel_hout_dikte;
    scherm_y_hart = 0;

    difference() {
        translate([
            -hout_buiten_x_min,
            hout_buiten_z_min-scherm_y_hart,
            grondplaat_boven_z
        ])
            rotate([90,0,0])
                houten_voorpaneel();

        translate([-hout_buiten_x_min,-scherm_y_hart,0])
            grondplaat_inzetuitsparingen(
                onderste_klem_y_hart,
                grondplaat_onder_z
            );
    }
}

// Compacte kunststof doorsteekinzet.
//
// De 16 mm diepe kern valt met 0,30 mm montagespeling in de uitsparing van de grondplaat.
// Symmetrische flens van 60 mm lang.
// Boven en onder gebruiken exact dezelfde vorm, verticaal gespiegeld.
//
// Aan beide uiteinden:
// - 1,5 mm rechte eindwand;
// - daarna 45° over 2,5 mm naar de volledige flensdikte van 4 mm.
module kunststof_symmetrische_flens(rechts=false,boven=true) {
    grondplaat_boven_z = onderbodem_onder_z-houten_voet_hoogte;
    grondplaat_onder_z = grondplaat_boven_z-voorpaneel_hout_dikte;
    scherm_y_hart = onderste_klem_y_hart;

    rand_x = rechts ? hout_buiten_x_max : hout_buiten_x_min;
    x0 = rechts ? rand_x-kunststof_flens_diepte : rand_x;
    x1 = rechts ? rand_x : rand_x+kunststof_flens_diepte;

    y0 = scherm_y_hart-kunststof_flens_lengte/2;
    y1 = scherm_y_hart+kunststof_flens_lengte/2;
    run = kunststof_positioneer_lengte_y;
    recht = kunststof_positioneer_recht_z;
    h = kunststof_inzet_flens;

    // Positieve lokale Z-vorm; onderflens wordt daarna gespiegeld.
    points_yz = [
        [y0,0],
        [y1,0],
        [y1,recht],
        [y1-run,h],
        [y0+run,h],
        [y0,recht]
    ];

    module positief_profiel(zbasis=0) {
        translate([0,0,zbasis])
            polyhedron(
                points=[
                    [x0,points_yz[0][0],points_yz[0][1]],
                    [x0,points_yz[1][0],points_yz[1][1]],
                    [x0,points_yz[2][0],points_yz[2][1]],
                    [x0,points_yz[3][0],points_yz[3][1]],
                    [x0,points_yz[4][0],points_yz[4][1]],
                    [x0,points_yz[5][0],points_yz[5][1]],

                    [x1,points_yz[0][0],points_yz[0][1]],
                    [x1,points_yz[1][0],points_yz[1][1]],
                    [x1,points_yz[2][0],points_yz[2][1]],
                    [x1,points_yz[3][0],points_yz[3][1]],
                    [x1,points_yz[4][0],points_yz[4][1]],
                    [x1,points_yz[5][0],points_yz[5][1]]
                ],
                faces=[
                    [0,1,2,3,4,5],
                    [11,10,9,8,7,6],
                    [0,6,7,1],
                    [1,7,8,2],
                    [2,8,9,3],
                    [3,9,10,4],
                    [4,10,11,5],
                    [5,11,6,0]
                ],
                convexity=10
            );
    }

    if(boven)
        positief_profiel(grondplaat_boven_z);
    else
        translate([0,0,2*grondplaat_onder_z])
            mirror([0,0,1])
                positief_profiel(grondplaat_onder_z);
}

// De boven- en onderflens zijn symmetrisch en 30 x 60 mm. Daardoor zijn er twee volledig
// gescheiden schroefzones: boven dicht bij de rand, onder verder naar binnen.
//
// De metalen beugel ligt rechtstreeks tegen de buitenzijde van de kern.
// De horizontale M4-bouten lopen alleen door beugel en kern.
// De houtschroeven gebruiken verschillende X- en Y-zones en kruisen elkaar niet.
module kunststof_randzadel(
    rechts=false,
    scherm_y_hart=onderste_klem_y_hart
) {
    grondplaat_boven_z = onderbodem_onder_z-houten_voet_hoogte;
    grondplaat_onder_z = grondplaat_boven_z-voorpaneel_hout_dikte;

    rand_x = rechts ? hout_buiten_x_max : hout_buiten_x_min;
    kern_y0 = scherm_y_hart-kunststof_kern_lengte/2;
    flens_y0 = scherm_y_hart-kunststof_flens_lengte/2;

    kern_x0 = rechts
        ? rand_x-kunststof_kern_diepte
        : rand_x;

    flens_x0 = rechts
        ? rand_x-kunststof_flens_diepte
        : rand_x;

    function wereld_x_vanaf_rand(xlokaal) =
        rechts ? rand_x-xlokaal : rand_x+xlokaal;

    color(kleur_kunststof_zadel)
    difference() {
        union() {
            // Kern door de volledige multiplexdikte.
            translate([kern_x0,kern_y0,grondplaat_onder_z])
                cube([
                    kunststof_kern_diepte,
                    kunststof_kern_lengte,
                    voorpaneel_hout_dikte
                ]);

            // Boven- en onderflens hebben exact dezelfde 60 mm vorm.
            kunststof_symmetrische_flens(rechts,true);
            kunststof_symmetrische_flens(rechts,false);
        }

        // 2 mm diepe opname voor de vlakke metalen haakplaat.
        // De opname loopt vanaf de onderzijde van het groene zadel omhoog,
        // zodat de freesrichting overeenkomt met de onderste klem.
        zadel_uitsparing_y0 =
            scherm_y_hart-klemuitsparing_breedte/2;

        zadel_uitsparing_z0 =
            grondplaat_onder_z-0.1;

        translate([
            rechts
                ? rand_x-metaalblok_verdieping-0.1
                : rand_x-0.1,
            zadel_uitsparing_y0,
            zadel_uitsparing_z0
        ])
            cube([
                metaalblok_verdieping+0.2,
                klemuitsparing_breedte,
                metaalblok_hoogte+0.2
            ]);

        // Twee horizontale M4-boutgaten door de kern.
        for(ylokaal=[
            kunststof_kern_lengte/2-kunststof_bout_hartafstand/2,
            kunststof_kern_lengte/2+kunststof_bout_hartafstand/2
        ]) {
            x_start = rechts ? rand_x+0.2 : rand_x-0.2;

            translate([
                x_start,
                kern_y0+ylokaal,
                grondplaat_onder_z+kunststof_bout_z
            ])
                rotate([0,rechts ? -90 : 90,0])
                    cylinder(
                        d=kunststof_boutgat_d,
                        h=kunststof_kern_diepte+0.4,
                        $fn=48
                    );

            // Zeskantige moeruitsparing aan de binnenzijde.
            x_moer = rechts
                ? rand_x-kunststof_kern_diepte-0.1
                : rand_x+kunststof_kern_diepte-kunststof_moer_diepte;

            translate([
                x_moer,
                kern_y0+ylokaal,
                grondplaat_onder_z+kunststof_bout_z
            ])
                rotate([0,90,0])
                    cylinder(
                        d=kunststof_moer_d,
                        h=kunststof_moer_diepte+0.2,
                        $fn=6
                    );
        }

        // Twee schroefgaten vanaf boven, buiten de kern.
        for(pos=kunststof_top_schroeven) {
            xgat = wereld_x_vanaf_rand(pos[0]);
            ygat = flens_y0+pos[1];

            translate([xgat,ygat,grondplaat_boven_z-8.1])
                cylinder(
                    d=kunststof_houtschroef_d,
                    h=12.2,
                    $fn=40
                );

            translate([
                xgat,
                ygat,
                grondplaat_boven_z+kunststof_inzet_flens
                    -kunststof_houtschroef_verzink_h
            ])
                cylinder(
                    d1=kunststof_houtschroef_d,
                    d2=kunststof_houtschroef_verzink_d,
                    h=kunststof_houtschroef_verzink_h+0.1,
                    $fn=40
                );
        }

        // Twee versprongen schroefgaten vanaf onder.
        for(pos=kunststof_onder_schroeven) {
            xgat = wereld_x_vanaf_rand(pos[0]);
            ygat = flens_y0+pos[1];

            translate([
                xgat,
                ygat,
                grondplaat_onder_z-kunststof_inzet_flens-0.1
            ])
                cylinder(
                    d=kunststof_houtschroef_d,
                    h=12.2,
                    $fn=40
                );

            translate([
                xgat,
                ygat,
                grondplaat_onder_z-kunststof_inzet_flens-0.1
            ])
                cylinder(
                    d1=kunststof_houtschroef_verzink_d,
                    d2=kunststof_houtschroef_d,
                    h=kunststof_houtschroef_verzink_h+0.1,
                    $fn=40
                );
        }
    }
}


// Twee platte metalen zijbeugels tegen de verticale zijranden van de grondplaat.
// De beugels blijven bewust vlak: nog geen krul of spansluiting.
//
// Afmetingen:
//   2 mm dik in X
//   20 mm lang in Y
//   16 mm hoog in Z
//   twee gaten Ø4,3 mm op 5 mm hoogte
module platte_zijbeugel() {
    // Bronmodel: X=lengte, Y=hoogte, Z=dikte.
    // Daarna omzetting naar wereldassen: bron X->Y, bron Y->Z, bron Z->X.
    multmatrix([
        [0,0,1,0],
        [1,0,0,0],
        [0,1,0,0],
        [0,0,0,1]
    ])
        difference() {
            linear_extrude(height=metaalblok_dikte,convexity=10)
                offset(r=metaalblok_hoekradius,$fn=48)
                    offset(delta=-metaalblok_hoekradius)
                        square([metaalblok_lengte,metaalblok_hoogte]);

            for(xgat=[
                metaalblok_lengte/2-metaalblok_gat_hartafstand/2,
                metaalblok_lengte/2+metaalblok_gat_hartafstand/2
            ])
                translate([xgat,metaalblok_gat_hoogte,-0.2])
                    cylinder(
                        d=metaalblok_gat_diameter,
                        h=metaalblok_dikte+0.4,
                        $fn=48
                    );
        }
}

module metalen_blokjes_op_grondplaat(
    include_inzetstukken=true,
    scherm_y_hart=onderste_klem_y_hart
) {
    assert(
    klemuitsparing_breedte == kunststof_flens_lengte,
    "The plastic insert and receiving recess must use the same length."
);

    // De liggende voorplaat vormt de grondplaat.
    grondplaat_boven_z = onderbodem_onder_z-houten_voet_hoogte;
    grondplaat_onder_z = grondplaat_boven_z-voorpaneel_hout_dikte;

    // Kunststof zadels in/om de multiplexrand.
    // In exploded view worden deze afzonderlijk uitgeschoven getoond.
    if(include_inzetstukken) {
        kunststof_randzadel(false,scherm_y_hart);
        kunststof_randzadel(true,scherm_y_hart);
    }

    // Links: metalen beugel tegen de buitenzijde van het kunststof zadel.
    color(kleur_metaalblok)
        translate([
            hout_buiten_x_min-metaalblok_dikte+metaalblok_verdieping,
            scherm_y_hart-metaalblok_lengte/2,
            grondplaat_onder_z
        ])
            platte_zijbeugel();

    // Rechts: metalen beugel tegen de buitenzijde van het kunststof zadel.
    color(kleur_metaalblok)
        translate([
            hout_buiten_x_max-metaalblok_verdieping,
            scherm_y_hart-metaalblok_lengte/2,
            grondplaat_onder_z
        ])
            platte_zijbeugel();
}

// Vereenvoudigde K2475 op basis van de datasheettekening.
//
// Lokale assen:
//   X = vanaf de kastwand naar buiten
//   Y = breedte van het onderdeel
//   Z = lengterichting van de spansluiting
//
// Dit is bewust nog geen volledig werkend hefboommechanisme. De hoofdvormen
// en de maatbetekenis volgen nu wel de datasheet:
//   - basiselement 43 x 16,5 mm;
//   - twee montagegaten Ø4,2 mm op 14 mm h.o.h.;
//   - totale gesloten lengte 73 mm;
//   - brede U-spanbeugel 23,5 mm met hoekig profiel van 2 x 3 mm.
// Toggle-clamp geometry moved to components/clamps.scad.

module onderste_klemplaten_op_zijwanden() {
    scherm_y_hart = onderste_klem_y_hart;

    // De hoogte wordt niet meer op gevoel gekozen.
    // De voorste dwarsstang van de U-spanbeugel wordt uitgelijnd op het
    // midden van de onderste metalen beugel aan de grondplaat.
    grondplaat_boven_z = onderbodem_onder_z-houten_voet_hoogte;
    grondplaat_onder_z = grondplaat_boven_z-voorpaneel_hout_dikte;
    onderste_beugel_hart_z =
        grondplaat_onder_z+metaalblok_hoogte/2;
    spanbeugel_voor_z_lokaal = -klem_spanbeugel_uitsteek;
    z0 = onderste_beugel_hart_z-spanbeugel_voor_z_lokaal;

    color(kleur_klemplaat)
        translate([
            hout_buiten_x_min+klemplaat_verdieping,
            scherm_y_hart-klemplaat_breedte/2,
            z0
        ])
            mirror([1,0,0])
                toggle_clamp(true);

    color(kleur_klemplaat)
        translate([
            hout_buiten_x_max-klemplaat_verdieping,
            scherm_y_hart-klemplaat_breedte/2,
            z0
        ])
            toggle_clamp(true);
}


module bovenste_klemplaten_op_zijwanden() {
    // Horizontale klemmen voor de verticale voorplaat.
    //
    // De montageplaat begint exact op de voorrand van de houten zijwand
    // en loopt vanaf daar naar achteren. Alleen de U-spanbeugel steekt
    // vóór de zijwand uit, richting de verticale voorplaat.
    // Zelfde effectieve randafstand als de onderste klem.
    zijwand_voorrand_y = bovenklem_montage_y;

    klem_hart_z = bovenklem_hart_z_exact;

    // Na rotate([-90,0,0]) wordt de lokale breedte de Z-richting.
    oorsprong_z =
        klem_hart_z+klem_basis_breedte/2;

    color(kleur_klemplaat)
        translate([
            hout_buiten_x_min+klemplaat_verdieping,
            zijwand_voorrand_y,
            oorsprong_z
        ])
            mirror([1,0,0])
                rotate([-90,0,0])
                    toggle_clamp(true);

    color(kleur_klemplaat)
        translate([
            hout_buiten_x_max-klemplaat_verdieping,
            zijwand_voorrand_y,
            oorsprong_z
        ])
            rotate([-90,0,0])
                toggle_clamp(true);
}


module vlakke_klemplaten_op_zijwanden() {
    onderste_klemplaten_op_zijwanden();

    if(toon_tweede_klemset)
        bovenste_klemplaten_op_zijwanden();
}

// ----------------------------------------------------------------------------
// Adam Hall 4900SM4AH rubberen voet, vereenvoudigde geometrie.
// ----------------------------------------------------------------------------

module rubberen_voeten_onder_grondplaat(
    show_steel_disc=true
) {
    grondplaat_boven_z =
        onderbodem_onder_z-houten_voet_hoogte;
    grondplaat_onder_z =
        grondplaat_boven_z-voorpaneel_hout_dikte;

    // De horizontaal gelegde voorplaat loopt in Y van
    // -hout_buiten_hoogte tot 0.
    grondplaat_y_min = -hout_buiten_hoogte;
    grondplaat_y_max = 0;

    x_posities = [
        hout_buiten_x_min+rubbervoet_rand_inset_x,
        hout_buiten_x_max-rubbervoet_rand_inset_x
    ];
    y_posities = [
        grondplaat_y_min+rubbervoet_rand_inset_y,
        grondplaat_y_max-rubbervoet_rand_inset_y
    ];

    for(x=x_posities)
        for(y=y_posities)
            translate([
                x,
                y,
                grondplaat_onder_z-rubbervoet_hoogte
            ])
                rubber_foot(
                    bottom_diameter=rubbervoet_boven_diameter,
                    mounting_diameter=rubbervoet_diameter,
                    height=rubbervoet_hoogte,
                    mounting_hole_diameter=rubbervoet_montagegat_d,
                    steel_disc_diameter=rubbervoet_boven_diameter-3,
                    show_steel_disc=show_steel_disc,
                    rubber_color=kleur_rubbervoet,
                    steel_color=kleur_rubbervoet_schijf
                );
}

// ----------------------------------------------------------------------------
// Complete afneembare voorplaat-subassemblage.
//
// Dezelfde fysieke plaat behoudt altijd:
// - de twee kunststof inzetstukken;
// - de twee onderste metalen beugels;
// - de vier rubbervoeten.
//
// Eerst wordt de complete plaat in de horizontale grondplaatstand opgebouwd.
// Voor gebruik als verticale voorplaat wordt exact diezelfde subassemblage
// als geheel teruggedraaid en vóór de eiken lijst geplaatst.
// ----------------------------------------------------------------------------
module voorplaat_subassemblage_horizontaal(
    include_inzetstukken=true,
    scherm_y_hart=onderste_klem_y_hart,
    show_steel_disc=true
) {
    voorplaat_als_grondplaat(scherm_y_hart);
    metalen_blokjes_op_grondplaat(
        include_inzetstukken,
        scherm_y_hart
    );
    rubberen_voeten_onder_grondplaat(show_steel_disc);
}

// ----------------------------------------------------------------------------
// De verticale voorplaat is exact dezelfde complete subassemblage als de
// horizontale grondplaat.
//
// Geen onderdelen worden opnieuw berekend of afzonderlijk geplaatst.
// De complete horizontale groep wordt met de inverse grondplaattransformatie
// teruggezet naar de oorspronkelijke verticale plaatstand. Daardoor blijven:
// - alle uitsparingen op exact dezelfde fysieke plek;
// - kunststof inzetstukken aan dezelfde plaatranden;
// - metalen onderbeugels op dezelfde gaten;
// - rubbervoeten aan hetzelfde plaatvlak.
// ----------------------------------------------------------------------------
module voorplaat_subassemblage_verticaal(
    include_inzetstukken=true,
    show_steel_disc=true
) {
    grondplaat_boven_z =
        onderbodem_onder_z-houten_voet_hoogte;

    // De kast staat in de complete montageweergave op montage_kast_y_shift.
    // De voorplaat moet exact dezelfde verschuiving krijgen.
    translate([0,montage_kast_y_shift,0])
        // Plaats het achtervlak van de plaat tegen het voorvlak van de eiken lijst.
        translate([
            0,
            gemonteerde_voorplaat_y-kast_y_voor,
            0
        ])
            // Inverse van rotate([90,0,0]) uit voorplaat_als_grondplaat().
            rotate([-90,0,0])
                // Inverse van de translate uit voorplaat_als_grondplaat().
                translate([
                    0,
                    -hout_buiten_z_min,
                    -grondplaat_boven_z
                ])
                    voorplaat_subassemblage_horizontaal(
                        include_inzetstukken,
                        onderste_klem_y_hart-montage_kast_y_shift,
                        show_steel_disc
                    );
}


// Standaard montageweergave: achterzijde open en voorplaat als grondplaat.
module normale_montageweergave(
    include_aluminium=toon_aluminium_frame,
    include_led_panelen=toon_led_panelen,
    include_acrylic=toon_plexiglas,
    include_ground_panel=toon_voorplaat_als_grondplaat,
    include_front_panel=toon_voorplaat_als_voorplaat,
    include_rear_panel=toon_achterplaat,
    show_steel_disc=true,
    include_roundwood=toon_roundwood_frame,
    include_roundwood_sockets=toon_roundwood_sockets,
    include_roundwood_cross_member=toon_roundwood_cross_member,
    include_roundwood_center_supports=toon_roundwood_center_supports
) {
    // De afneembare plaat blijft compleet, ongeacht de gekozen stand.
    if(include_ground_panel)
        voorplaat_subassemblage_horizontaal(
            true,
            onderste_klem_y_hart,
            show_steel_disc
        );

    if(include_front_panel)
        voorplaat_subassemblage_verticaal(
            true,
            show_steel_disc
        );

    // Kast zonder ingebouwde voorplaat; die wordt hierboven als complete
    // subassemblage geplaatst.
    translate([0,montage_kast_y_shift,0])
        houten_frame_assemblage(
            false,
            false,
            include_rear_panel,
            include_aluminium,
            include_led_panelen,
            include_acrylic,
            include_roundwood,
            include_roundwood_sockets,
            include_roundwood_cross_member,
            include_roundwood_center_supports
        );

    // De zij-klemmen horen bij de kast en blijven altijd zichtbaar.
    vlakke_klemplaten_op_zijwanden();
}

// Exploded view van dezelfde open montageopstelling.
module exploded_montageweergave(
    include_aluminium=toon_aluminium_frame,
    include_led_panelen=toon_led_panelen,
    include_acrylic=toon_plexiglas,
    include_ground_panel=toon_voorplaat_als_grondplaat,
    include_front_panel=toon_voorplaat_als_voorplaat,
    include_rear_panel=toon_achterplaat,
    show_steel_disc=true,
    include_roundwood=toon_roundwood_frame,
    include_roundwood_sockets=toon_roundwood_sockets,
    include_roundwood_cross_member=toon_roundwood_cross_member,
    include_roundwood_center_supports=toon_roundwood_center_supports
) {
    // Horizontale variant: complete plaatgroep verder omlaag.
    if(include_ground_panel)
        translate([0,0,grondplaat_explode_z])
            voorplaat_subassemblage_horizontaal(
                false,
                onderste_klem_y_hart,
                show_steel_disc
            );

    // Verticale variant: complete plaatgroep recht vóór de kast trekken.
    if(include_front_panel)
        translate([0,voorplaat_explode_y,0])
            voorplaat_subassemblage_verticaal(
                false,
                show_steel_disc
            );

    // Kast zonder dubbel gemonteerde voorplaat.
    translate([0,montage_kast_y_shift,0])
        houten_frame_assemblage(
            true,
            false,
            include_rear_panel,
            include_aluminium,
            include_led_panelen,
            include_acrylic,
            include_roundwood,
            include_roundwood_sockets,
            include_roundwood_cross_member,
            include_roundwood_center_supports
        );

    // Klemmen blijven aan de kast en verdwijnen nooit door een plaatoptie.
    translate([0,18,0])
        vlakke_klemplaten_op_zijwanden();

    // Inzetstukken apart uit de plaat trekken, maar slechts één keer tonen.
    if(include_ground_panel) {
        translate([-inzet_explode_x,-18,grondplaat_explode_z])
            kunststof_randzadel(false);
        translate([inzet_explode_x,-18,grondplaat_explode_z])
            kunststof_randzadel(true);
    }

}

// ----------------------------------------------------------------------------
// View selector.
// Losse houtdelen worden vlak op Z=0 gelegd voor export/controle.
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Losse 3D-printviews.
// De onderdelen worden naar de oorsprong verplaatst en in een eenvoudige
// printoriëntatie gezet, zodat ze afzonderlijk geëxporteerd kunnen worden.
// ----------------------------------------------------------------------------

module print_kunststof_inzet(rechts=false) {
    // Eerst het onderdeel in zijn eigen broncoördinaten rond de oorsprong zetten.
    rand_x = rechts ? hout_buiten_x_max : hout_buiten_x_min;
    centrum_x = rechts
        ? rand_x-kunststof_flens_diepte/2
        : rand_x+kunststof_flens_diepte/2;
    centrum_y = montage_kast_y_shift+(kast_y_voor+kast_y_achter)/2;
    grondplaat_boven_z = onderbodem_onder_z-houten_voet_hoogte;
    grondplaat_onder_z = grondplaat_boven_z-voorpaneel_hout_dikte;
    centrum_z = (grondplaat_boven_z+kunststof_inzet_flens
        +grondplaat_onder_z-kunststof_inzet_flens)/2;

    // Daarna in printoriëntatie draaien. Het geometrische centrum blijft bij 0.
    rotate([0,rechts ? 90 : -90,0])
        translate([-centrum_x,-centrum_y,-centrum_z])
            kunststof_randzadel(rechts);
}

module print_hoekbeugel(rechts=false,voor=true) {
    y0 = voor ? kast_y_voor : kast_y_achter-hoekbeugel_breedte_y;
    rand_x = rechts ? hout_buiten_x_max : hout_buiten_x_min;
    z_onder = onderbodem_onder_z-hoekbeugel_voethoogte_z;

    // Benaderd geometrisch centrum van de volledige L-beugel.
    centrum_x = rechts
        ? rand_x+(hoekbeugel_zijdikte_x-hoekbeugel_voetlengte_x)/2
        : rand_x-(hoekbeugel_zijdikte_x-hoekbeugel_voetlengte_x)/2;
    centrum_y = y0+hoekbeugel_breedte_y/2;
    centrum_z = z_onder+(hoekbeugel_zijhoogte+hoekbeugel_voethoogte_z)/2;

    rotate([0,rechts ? 90 : -90,0])
        translate([-centrum_x,-centrum_y,-centrum_z])
            kunststof_hoekbeugel(rechts,y0);
}

module print_hoekbeugels_set() {
    afstand = hoekbeugel_breedte_y + 12;

    translate([0,-1.5*afstand,0])
        print_hoekbeugel(false,true);
    translate([0,-0.5*afstand,0])
        print_hoekbeugel(false,false);
    translate([0,0.5*afstand,0])
        print_hoekbeugel(true,true);
    translate([0,1.5*afstand,0])
        print_hoekbeugel(true,false);
}

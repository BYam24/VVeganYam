open Bogue
module W = Widget
module L = Layout
module T = Trigger
open Tsdl

let section_title s = L.flat_of_w [ W.label ~size:12 ~fg:Draw.(opaque grey) s ]

(** [icon_button name] makes an icon button of [name] *)
let icon_button name =
  let fg = Draw.(opaque black) in
  W.button ~kind:Button.Switch ~label_on:(Label.icon ~fg name)
    ~label_off:(Label.icon ~fg:Draw.(lighter (lighter fg)) name)
    ""

let hline width =
  let style = Style.(empty |> with_bg (color_bg Draw.(transp black))) in
  L.resident (W.box ~w:width ~h:1 ~style ())

let song_title = "What is Love? - Twice"
let song_ref = "April 9th, 2018"

let fable =
  "Every day, in a movie\n\
   In a book or in a drama, I feel love\n\
   Um- I learn about love\n\
   My heart keeps beating as if it's my own story\n\
   Makes my heart pound and swell with hope\n\
   Um- I want to know so bad\n\n\
   [Pre-Chorus: Mina, Chaeyoung]\n\
   Ooh, maybe someday\n\
   Could it happen to me too?\n\
   When will it be? Who will it be?\n\n\
   [Chorus: Sana, Tzuyu]\n\
   (I wanna know) How it could be as sweet as candy?\n\
   (I wanna know) How it's like flying in the sky?\n\
   I wanna know know know know\n\
   What is love?\n\
   What love feels like?\n\
   (I wanna know) How it keeps you smiling all day?\n\
   (I wanna know) How the whole world turns beautiful?\n\
   I wanna know know know know\n\
   What is love?\n\
   Will love come to me someday?\n\
   You might also like\n\
   Cupid (Twin Version)\n\
   FIFTY FIFTY (피프티피프티)\n\
   Die For You (Remix)\n\
   The Weeknd & Ariana Grande\n\
   Boy’s a liar Pt. 2\n\
   PinkPantheress & Ice Spice\n\
   Just imagining all of this\n\
   Just thinking about it\n\
   Almost makes my heart burst\n\
   Um- How good it feels?\n\
   If, one day, for real\n\
   Love does comes to me, I might just cry\n\
   Um- I really want to know how it feels\n\n\
   [Pre-Chorus: Mina, Dahyun]\n\
   Ooh, maybe someday\n\
   Could it happen to me too?\n\
   When will it be? Who will it be?\n\n\
   [Chorus: Sana, Tzuyu]\n\
   (I wanna know) How it could be as sweet as candy?\n\
   (I wanna know) How it's like flying in the sky?\n\
   I wanna know know know know\n\
   What is love?\n\
   What love feels like?\n\
   (I wanna know) How it keeps you smiling all day?\n\
   (I wanna know) How the whole world turns beautiful?\n\
   I wanna know know know know\n\
   What is love?\n\
   Will love come to me someday?\n\n\
   [Verse 3: Dahyun, Chaeyoung]\n\
   Where in the world are you right now?\n\
   Just when will we get to meet each other?\n\
   When and how might our relationship start?\n\
   I don't know right now, but somehow I feel\n\
   That it will be really good\n\
   Better than any movie or drama\n\
   The greatest love will come\n\
   My gut instinct is always right\n\
   C'mon, show yourself, i'm all set, Ready!\n\
   [Bridge: Sana, Jeongyeon, Nayeon]\n\
   (wonder where you are) I'm gonna find you\n\
   (wonder where you are) I'm so dying to see you\n\
   I can't take it much longer\n\n\
   How it could be as sweet as candy?\n\
   How it's like flying in the sky?\n\
   I wanna know know know know\n\
   What is love?\n\
   What love feels like?\n\
   How it keeps you smiling all day?\n\
   How the whole world turns beautiful?\n\
   I wanna know know know know\n\
   What is love?\n\
   Will love come to me someday?\n\n\
   [Outro: Sana, Tzuyu, All]\n\
   I wanna know\n\
   I wanna know\n\
   I wanna know know know know\n\
   What is love?\n\
   I wanna know I wanna know\n\
   I wanna know\n\
   I wanna know\n\
   I wanna know know know know\n\
   What is love?\n\
   I wanna know"

(* let survey_display () = let input = W.text_input ~max_size:200 ~prompt:"Enter
   your name" () in let label = W.label ~size:40 "Hello!" in let layout =
   L.tower [ L.resident ~w:400 input; L.resident ~w:400 ~h:200 label ] in

   let before_display () = let text = W.get_text input in W.set_text label
   ("Hello " ^ text ^ "!") in

   let board = Bogue.make [] [ layout ] in Bogue.run ~before_display board *)
let after_display () = ignore (W.label "bye")

let main () =
  (* let input = W.text_input ~max_size:200 ~prompt:"Enter your name" () in *)
  let label = W.label ~size:25 "Submit" in

  let before_survey_display () =
    (* let text = W.get_text input in *)
    W.set_text label "Questionnaire Time!"
  in

  let check_title =
    W.html ~h:20 "<strong> What are your favorite music genres? </strong>"
  in
  let check1 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Pop" ] in
  let check2 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Classical" ] in
  let check3 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Rock" ] in
  let check4 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Country" ] in

  let question_1 =
    L.tower ~margins:10 ~sep:0
      [ L.resident ~w:400 ~h:20 check_title; check1; check2; check3; check4 ]
  in

  let check_title =
    W.html ~h:20 "<strong> What are your favorite eras of music? </strong>"
  in
  let check_box_1_1 = W.check_box () in
  let check1 = L.flat_of_w ~sep:2 [ check_box_1_1; W.label "pre-1800s" ] in
  let check2 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "1850-1900s" ] in
  let check3 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "1900-1950s" ] in
  let check4 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "1950-2000s" ] in
  let check5 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "2000-Present" ] in

  let question_2 =
    L.tower ~margins:10 ~sep:0
      [
        L.resident ~w:400 ~h:20 check_title;
        check1;
        check2;
        check3;
        check4;
        check5;
      ]
  in

  let check_title =
    W.html ~h:20 "<strong> Do you listen to any these artists? </strong>"
  in
  let check1 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Ed Sheeran" ] in
  let check2 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "The Weekend" ] in
  let check4 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Taylor Swift" ] in
  let check5 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Post Malone" ] in
  let question_3 =
    L.tower ~margins:10 ~sep:0
      [ L.resident ~w:400 ~h:20 check_title; check1; check2; check4; check5 ]
  in

  let check_title =
    W.html ~h:20
      "<strong> Which type of music do you prefer for a relaxed evening? \
       </strong>"
  in
  let check1 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Jazz" ] in
  let check2 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Classical" ] in
  let check3 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "R&B" ] in
  let check5 = L.flat_of_w ~sep:2 [ W.check_box (); W.label "Ambient" ] in

  let question_4 =
    L.tower ~margins:10 ~sep:0
      [ L.resident ~w:400 ~h:20 check_title; check1; check2; check3; check5 ]
  in

  let button_submit = W.button ~border_radius:10 ~kind:Button.Switch "Submit" in

  (* let answers = [] in

     let checklist = [L.widget check1; L.widget check2; L.widget check3;
     L.widget check4 ] in

     let rec get_answers check_list answers = match check_list with | [] -> () |
     h :: t -> if W.get_state h then (ignore(W.get_text h :: answers);
     get_answers t answers) else get_answers t answers

     in *)

  (* W.on_click button_submit (get_answers checklist answers); *)

  (* let radio_title = section_title "Radio buttons. Only one can be selected."
     in let radio = Radiolist.vertical [| "select this"; "or rather that";
     "maybe this"; "worst case, this one"; |] in let radio_layout = L.tower
     ~margins:0 ~sep:0 [ radio_title; Radiolist.layout radio ] in *)
  let survey =
    L.tower
      [
        L.resident ~w:400 ~h:90 label;
        question_1;
        question_2;
        question_3;
        question_4;
        L.resident button_submit;
      ]
  in

  (* let question_1 = "What ?" in let text = W.text_display ~w:width ~h:630
     question_1 in

     let text_ref = W.rich_text ~w:width ~h:20 Text_display.(page [ italic (para
     song_ref) ]) in let text_layout = L.tower [ L.resident text; L.resident
     text_ref ] in let text_container = L.make_clip ~h:340 text_layout in

     let survey_page = L.tower [ text_container; ] in *)
  let width = 400 in

  (* quit button *)
  let quit_title = section_title "Popup window" in
  let quit_btn = W.button ~border_radius:10 "QUIT" in
  let yes_action () = T.push_quit () in
  let no_action () = () in

  let quit_layout =
    L.tower ~margins:0 ~align:Draw.Center [ quit_title; L.resident quit_btn ]
  in

  (* Page 1: check buttons, radio, and text scrolling *)
  let input_title = section_title "Text input" in
  let ti = W.text_input ~prompt:"What you looking for ? " () in
  let input =
    L.flat_of_w ~align:Draw.Center [ W.label "Enter your name:"; ti ]
  in
  let input_layout = L.tower ~margins:0 [ input_title; input ] in

  let hello_title = section_title "Dynamic text" in
  let hello = W.label ~size:40 "Hello!" in
  let hello_action = W.map_text (fun s -> "Hello " ^ s ^ "!") in
  let c_hello =
    W.connect ti hello hello_action Sdl.Event.[ text_input; key_down ]
  in
  let hello_layout =
    L.tower ~margins:0 [ hello_title; L.resident ~w:width hello ]
  in

  (* let check_title = section_title "Check buttons" in let check1 = L.flat_of_w
     ~sep:2 [ W.check_box (); W.label "check this" ] in let check2 = L.flat_of_w
     ~sep:2 [ W.check_box (); W.label "check that" ] in let check3 = L.flat_of_w
     ~sep:2 [ W.check_box (); W.label "or this" ] in let check_layout = L.tower
     ~margins:0 [ check_title; check1; check2; check3 ] in *)

  (* let radio_title = section_title "Radio buttons. Only one can be selected."
     in let radio = Radiolist.vertical [| "select this"; "or rather that";
     "maybe this"; "worst case, this one"; |] in let radio_layout = L.tower
     ~margins:0 ~sep:0 [ radio_title; Radiolist.layout radio ] in *)

  (* let icon_title = section_title "Icon buttons." in let icon1 = icon_button
     "play" in let icon2 = icon_button "pause" in let icon3 = icon_button "stop"
     in let icon4 = icon_button "repeat" in let icons = L.flat_of_w [ icon1;
     icon2; icon3; icon4 ] in let icon_layout = L.tower ~margins:0 [ icon_title;
     icons ] in *)
  let text_title = section_title "Fetched Song Description" in
  let text_head =
    W.rich_text ~size:20 ~w:width ~h:30
      Text_display.(page [ bold (para song_title) ])
  in
  let text = W.text_display ~w:width ~h:630 fable in
  let text_ref =
    W.rich_text ~w:width ~h:20 Text_display.(page [ italic (para song_ref) ])
  in
  let text_layout =
    L.tower
      [ text_title; L.resident text_head; L.resident text; L.resident text_ref ]
  in
  let text_container = L.make_clip ~h:340 text_layout in

  let page1 =
    L.tower
      [
        quit_layout;
        input_layout;
        hline width;
        hello_layout;
        (* hline width; icon_layout; hline width; check_layout; hline width;
           radio_layout; *)
        hline width;
        text_container;
      ]
  in

  (* Page 2: text input ... *)
  (* let input_title = section_title "Text input" in let ti = W.text_input
     ~prompt:"John Doo-Doo Wap" () in let input = L.flat_of_w ~align:Draw.Center
     [ W.label "Enter your name:"; ti ] in let input_layout = L.tower ~margins:0
     [ input_title; input ] in

     let hello_title = section_title "Dynamic text" in let hello = W.label
     ~size:40 "Hello!" in let hello_action = W.map_text (fun s -> "Hello " ^ s ^
     "!") in let c_hello = W.connect ti hello hello_action Sdl.Event.[
     text_input; key_down ] in let hello_layout = L.tower ~margins:0 [
     hello_title; L.resident ~w:width hello ] in *)
  let play_button = icon_button "play" in

  (* layout *)
  let layout_gui2 =
    L.tower ~margins:0
      [ section_title "Play button"; L.resident ~w:(width / 8) play_button ]
  in
  (******************************************************)
  let slider_title = section_title "Progress bar or slider" in
  let slider = W.slider ~kind:Slider.HBar 100 in
  let percent = W.label "    0%" in
  let set_percent w x = Label.set (W.get_label w) (Printf.sprintf "%u%%" x) in
  let action w1 w2 _ =
    let x = Slider.value (W.get_slider w1) in
    set_percent w2 x
  in
  let events =
    List.flatten
      [ T.buttons_down; T.buttons_up; T.pointer_motion; [ Sdl.Event.key_down ] ]
  in
  let c_slider = W.connect slider percent action events in
  let slider_l = L.resident ~background:L.theme_bg slider in
  let slider_bar = L.flat ~align:Draw.Center [ slider_l; L.resident percent ] in
  let slider_layout = L.tower ~margins:0 [ slider_title; slider_bar ] in

  let buttons_title = section_title "Push and toggle buttons" in
  let button_reset = W.button ~border_radius:10 "Reset" in
  let click _ =
    Slider.set (W.get_slider slider) 0;
    Label.set (W.get_label percent) " 0%"
    (* it would be great if this could be done automatically. *)
  in
  W.on_click ~click button_reset;
  let button_start =
    W.button ~border_radius:10 ~kind:Button.Switch "Start computing"
  in
  let start_action b s ev =
    let bw = W.get_button b in
    let sw = W.get_slider s in
    let state = Button.state bw in
    if state then
      let rec loop () =
        let x = Slider.value sw in
        if x >= 100 || T.should_exit ev then (
          T.will_exit ev;
          Button.reset bw)
        else (
          Slider.set sw (x + 1);
          set_percent percent (x + 1);
          W.update s;
          T.nice_delay ev 0.1;
          loop ())
      in
      loop ()
    else W.update percent
  in
  let c_button =
    W.connect ~priority:W.Replace button_start slider start_action T.buttons_up
  in

  let buttons_layout =
    L.tower ~margins:0
      [ buttons_title; L.flat_of_w [ button_reset; button_start ] ]
  in

  (* images *)
  (* let image_title = section_title "Image display" in let image = W.image
     ~w:(width / 2) "images/play.png" in let image_layout = L.tower ~margins:0 [
     image_title; L.resident image ] in

     let bottom = L.flat ~align:Draw.Max ~margins:0 [ image_layout; Space.hfill
     () ] in L.set_width bottom width; *)
  let page2 =
    L.tower
      [
        layout_gui2;
        hline width;
        slider_layout;
        hline width;
        buttons_layout;
        hline width (* bottom; *);
      ]
  in

  let tabs =
    Tabs.create ~slide:Avar.Right
      [ ("Artist descriptions", page1); ("Music Playing", page2) ]
  in

  (* Notice we need to put this code after definition of the main layout. *)
  let release _ =
    Popup.yesno ~w:100 ~h:50 "Really quit?" ~yes_action ~no_action tabs
  in
  W.on_button_release ~release quit_btn;

  W.on_click ~click:(fun _ -> Play.load_audio_file ()) play_button;
  let board = Main.make [ c_hello; c_slider; c_button ] [ tabs; survey ] in
  Main.run ~before_display:before_survey_display board

let () =
  main ();
  Bogue.quit ()

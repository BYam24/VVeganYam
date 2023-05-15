(* ---- Testing Plan ----*)
(** This is our project's testing suite. It is composed of over 60 tests
    excluding tests that were manually disabled to maintain integrity of the
    database and to prevent multiple web pages being opened every time the test
    suite is ran. The test suite encompasses all the functions in the songfuncs
    module, the main module responsible for retrieving data from and
    manipulating the database of songs in addition to being able to open urls on
    the user's machine's default browser. The frontend of this project mostly
    comprises of the GUI and the functions and definitions that make that
    possible. These are not tested in this testing suite because GUI components
    build on top of each other and would not fully represent the GUI if testing
    this way.

    This testing suite provides automated testing of all the functions within
    songfuncs on two json files made for testing except for functions that
    manipulate jsons or opens urls. The disabled functions were enabled
    routinely for manual testing to ensure the correctness of them.

    What is almost entirely manually tested is the GUI component of our project.
    This is mostly due to the complexity and layering of its individual
    components which make it difficult to test isolated portions of the GUI, so
    we opted to go for manual testing.

    Whether automated or manual, our testing efforts were all under glass-box
    testing ideas to allow for as much specified code coverage. Additionally,
    songfuncs is the only module that is tested in this testing suite.

    We believe that this testing approach demonstrates the correctness of this
    system because the backend, SongList json and songfuncs module, are what
    implement the functionality for the GUI and these are the most important to
    test and make sure nothing can break for them. This is especially true for
    database implementations. The GUI, on the other hand, is always being viewed
    with sharp eyes since every time something new is being added, the GUI is
    ran to test the new feature. This meticulous system of manual testing and
    implementation is what allows us to have the GUI work excellently and most
    importantly, bugless. *)

open OUnit2
open Otunes
open Songfuncs

let songs = Yojson.Basic.from_file "fortests.json"
let songs2 = Yojson.Basic.from_file "empty.json"
let testing = Yojson.Basic.from_file "SongList"

let to_string_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output :
      (string * string * string * string * string * string * string) list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output (to_string_list (from_json json))

let title_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (title_list (from_json json))

let genre_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (genre_list (from_json json))

let album_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (album_list (from_json json))

let ytlinks_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (ytlinks_list (from_json json))

let song_by_title_test (name : string) (title : string) (json : Yojson.Basic.t)
    (expected_output :
      (string * string * string * string * string * string * string) list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output (song_by_title title (from_json json))

let song_list_by_artist_test (name : string) (artist : string)
    (json : Yojson.Basic.t)
    (expected_output :
      (string * string * string * string * string * string * string) list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output (song_list_by_artist artist (from_json json))

let ytlink_by_title_test (name : string) (title : string)
    (json : Yojson.Basic.t) (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (ytlink_by_title title (from_json json))

let artist_by_title_test (name : string) (title : string)
    (json : Yojson.Basic.t) (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (artist_by_title title (from_json json))

let album_by_title_test (name : string) (title : string) (json : Yojson.Basic.t)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (album_by_title title (from_json json))

let genre_by_title_test (name : string) (title : string) (json : Yojson.Basic.t)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (genre_by_title title (from_json json))

let add_song_test (name : string) (title : string) (artist : string)
    (album : string) (genre : string) (length : string) (date : string)
    (ytlink : string) (expected_output : unit) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (add_song_to_json title artist album genre length date ytlink)

let remove_song_test (name : string) (title : string) (artist : string)
    (json : Yojson.Basic.t) (expected_output : unit) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (remove_song_to_json title artist (from_json json))

(* let string_json_test (name : string) (title : string) (str : string)
   (expected_output : unit) : test = name >:: fun _ -> assert_equal
   expected_output (json_with_string title str) *)

(* let open_url_test (name : string) (url : string) (expected_output : unit) :
   test = name >:: fun _ -> assert_equal expected_output (open_url url) *)

let printers str = str

let to_string_t (name : string) (json : Yojson.Basic.t)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (Yojson.Basic.to_string json) ~printer:printers

let suite =
  "test suite for final project, OTunes"
  >::: [
         to_string_t "" songs2 {|{"songs":[]}|};
         (* string_json_test "TESTING STRING" "t" {| {} |} (); *)
         (* remove_song_test "Removes example song to song json" "extitle"
            "exartist" testing (); remove_song_test "Removes double to song
            json" "double" "bbno$" testing (); remove_song_test "Removes
            heatseeker to song json" "heatseeker" "$werve" testing ();
            remove_song_test "Removes out of reach to song json" "out of reach"
            "boywithuke" testing (); remove_song_test "Removes suzume to song
            json" "suzume" "radwimps" testing (); remove_song_test "Removes
            likey to song json" "likey" "twice" testing (); *)
         add_song_test "Adds green light to the song json" "green light" "lorde"
           "exalbum" "exgenre" "exlength" "exdate" "exytlink" ();
         remove_song_test "Removes green light to song json" "green light"
           "lorde" testing ();
         (* add_song_test "Adds likey to the song json" "likey" "twice"
            "exalbum" "exgenre" "exlength" "exdate" "exytlink" ();
            remove_song_test "Removes likey to song json" "likey" "twice"
            testing (); *)
         (* add_song_test "Adds double to the song json" "double" "bbno$"
            "exalbum" "exgenre" "exlength" "exdate" "exytlink" (); add_song_test
            "Adds heatseeker to the song json" "heatseeker" "$werve" "exalbum"
            "exgenre" "exlength" "exdate" "exytlink" (); add_song_test "Adds out
            of reach to the song json" "out of reach" "boywithuke" "exalbum"
            "exgenre" "exlength" "exdate" "exytlink" (); add_song_test "Adds
            suzume to the song json" "suzume" "radwimps" "exalbum" "exgenre"
            "exlength" "exdate" "exytlink" (); add_song_test "Adds an example to
            the song json" "extitle" "exartist" "exalbum" "exgenre" "exlength"
            "exdate" "exytlink" (); *)
         to_string_list_test "for songs" songs
           [
             ( "Pompeii",
               "Bastille",
               "Bad Blood",
               "Rock",
               "3:34",
               "2013",
               "https://www.youtube.com/watch?v=F90Cw4l-8NY" );
             ( "Für Elise",
               "Ludwig van Beethoven",
               "",
               "Classical",
               "2:55",
               "1867",
               "https://www.youtube.com/watch?v=c1iZXyWLnXg" );
             ( "Billie Jean",
               "Michael Jackson",
               "Thriller",
               "Pop",
               "4:54",
               "1983",
               "https://www.youtube.com/watch?v=Zi_XLOBDo_Y" );
             ( "What A Wonderful World",
               "Louis Armstrong",
               "What a Wonderful World",
               "Jazz",
               "2:21",
               "1967",
               "https://www.youtube.com/watch?v=VqhCQZaH4Vs" );
             ( "In Da Club",
               "50 Cent",
               "Get Rich or Die Tryin'",
               "Hip Hop",
               "3:13",
               "2003",
               "https://www.youtube.com/watch?v=5qm8PH4xAss" );
           ];
         to_string_list_test "for songs2" songs2 [];
         title_list_test "for songs" songs
           [
             "Pompeii";
             "Für Elise";
             "Billie Jean";
             "What A Wonderful World";
             "In Da Club";
           ];
         title_list_test "for songs2" songs2 [];
         genre_list_test "for songs" songs
           [ "Classical"; "Hip Hop"; "Jazz"; "Pop"; "Rock" ];
         genre_list_test "for songs2" songs2 [];
         album_list_test "for songs" songs
           [
             "Bad Blood";
             "Thriller";
             "What a Wonderful World";
             "Get Rich or Die Tryin'";
           ];
         album_list_test "for songs2" songs2 [];
         ytlinks_list_test "for songs" songs
           [
             "https://www.youtube.com/watch?v=F90Cw4l-8NY";
             "https://www.youtube.com/watch?v=c1iZXyWLnXg";
             "https://www.youtube.com/watch?v=Zi_XLOBDo_Y";
             "https://www.youtube.com/watch?v=VqhCQZaH4Vs";
             "https://www.youtube.com/watch?v=5qm8PH4xAss";
           ];
         ytlinks_list_test "for songs2" songs2 [];
         song_by_title_test "for songs" "Pompeii" songs
           [
             ( "Pompeii",
               "Bastille",
               "Bad Blood",
               "Rock",
               "3:34",
               "2013",
               "https://www.youtube.com/watch?v=F90Cw4l-8NY" );
           ];
         song_by_title_test "for songs" "Billie Jean" songs
           [
             ( "Billie Jean",
               "Michael Jackson",
               "Thriller",
               "Pop",
               "4:54",
               "1983",
               "https://www.youtube.com/watch?v=Zi_XLOBDo_Y" );
           ];
         song_by_title_test "for songs2" "dnjlkd" songs2 [];
         song_by_title_test "for songs2" "green light" songs2 [];
         song_list_by_artist_test "for songs" "Bastille" songs
           [
             ( "Pompeii",
               "Bastille",
               "Bad Blood",
               "Rock",
               "3:34",
               "2013",
               "https://www.youtube.com/watch?v=F90Cw4l-8NY" );
           ];
         song_list_by_artist_test "for songs" "Michael Jackson" songs
           [
             ( "Billie Jean",
               "Michael Jackson",
               "Thriller",
               "Pop",
               "4:54",
               "1983",
               "https://www.youtube.com/watch?v=Zi_XLOBDo_Y" );
           ];
         song_list_by_artist_test "for songs2" "dnjlkd" songs2 [];
         song_list_by_artist_test "for songs2" "lorde" songs2 [];
         ytlink_by_title_test "for songs" "Pompeii" songs
           "https://www.youtube.com/watch?v=F90Cw4l-8NY";
         ytlink_by_title_test "for songs" "Billie Jean" songs
           "https://www.youtube.com/watch?v=Zi_XLOBDo_Y";
         ytlink_by_title_test "for songs" "Für Elise" songs
           "https://www.youtube.com/watch?v=c1iZXyWLnXg";
         ytlink_by_title_test "for songs" "What A Wonderful World" songs
           "https://www.youtube.com/watch?v=VqhCQZaH4Vs";
         ytlink_by_title_test "for songs" "In Da Club" songs
           "https://www.youtube.com/watch?v=5qm8PH4xAss";
         ytlink_by_title_test "for songs2" "dsafds" songs2 "";
         ytlink_by_title_test "for songs2" "green light" songs2 "";
         ytlink_by_title_test "for songs2" "likey" songs2 "";
         ytlink_by_title_test "for songs2" "mr. blue sky" songs2 "";
         ytlink_by_title_test "for songs2" "billie jean" songs2 "";
         artist_by_title_test "for songs" "Pompeii" songs "Bastille";
         artist_by_title_test "for songs" "Billie Jean" songs "Michael Jackson";
         artist_by_title_test "for songs" "Für Elise" songs
           "Ludwig van Beethoven";
         artist_by_title_test "for songs" "What A Wonderful World" songs
           "Louis Armstrong";
         artist_by_title_test "for songs" "In Da Club" songs "50 Cent";
         artist_by_title_test "for songs2" "wrqwewq" songs2 "";
         artist_by_title_test "for songs2" "green light" songs2 "";
         artist_by_title_test "for songs2" "likey" songs2 "";
         artist_by_title_test "for songs2" "double" songs2 "";
         artist_by_title_test "for songs2" "jurassic" songs2 "";
         album_by_title_test "for songs" "Pompeii" songs "Bad Blood";
         album_by_title_test "for songs" "Billie Jean" songs "Thriller";
         album_by_title_test "for songs" "Für Elise" songs "";
         album_by_title_test "for songs" "What A Wonderful World" songs
           "What a Wonderful World";
         album_by_title_test "for songs" "In Da Club" songs
           "Get Rich or Die Tryin'";
         artist_by_title_test "for songs2" "boulevard of broken dreams" songs2
           "";
         artist_by_title_test "for songs2" "likey" songs2 "";
         artist_by_title_test "for songs2" "double" songs2 "";
         artist_by_title_test "for songs2" "jurassic" songs2 "";
         artist_by_title_test "for songs2" "fancy" songs2 "";
         genre_by_title_test "for songs" "Pompeii" songs "Rock";
         genre_by_title_test "for songs" "Billie Jean" songs "Pop";
         genre_by_title_test "for songs" "What A Wonderful World" songs "Jazz";
         genre_by_title_test "for songs" "In Da Club" songs "Hip Hop";
         artist_by_title_test "for songs2" "jurassic" songs2 "";
         artist_by_title_test "for songs2" "likey" songs2 "";
         artist_by_title_test "for songs2" "fancy" songs2 "";
         artist_by_title_test "for songs2" "green light" songs2 "";
         artist_by_title_test "for songs2" "undefeated" songs2 ""
         (* open_url_test "Opens the ytlink for Bastille - Pompeii"
            "https://www.youtube.com/watch?v=F90Cw4l-8NY" (); open_url_test
            "Opens the ytlink for Beethoven - fur elise"
            "https://www.youtube.com/watch?v=c1iZXyWLnXg" (); open_url_test
            "Opens the ytlink for Michael Jackson - Billie Jean"
            "https://www.youtube.com/watch?v=Zi_XLOBDo_Y" (); open_url_test
            "Opens the ytlink for Louis Armstrong - What a wonderful world"
            "https://www.youtube.com/watch?v=VqhCQZaH4Vs" (); *);
       ]

let _ = run_test_tt_main suite

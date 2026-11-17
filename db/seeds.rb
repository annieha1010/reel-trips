puts "Cleaning database..."
User.destroy_all
Place.destroy_all
Trip.destroy_all

puts "Creating users..."
user_annie = User.create!(
  email: "annie@rails.com",
  password: "123123"
)
user_paul = User.create!(
  email: "paul@rails.com",
  password: "123123"
)
user_jon = User.create!(
  email: "jon@rails.com",
  password: "123123"
)
user_yoshi = User.create!(
  email: "yoshi@rails.com",
  password: "123123"
)

puts "Finished! Created #{User.count} user(s)."

place1 = Place.create!(
  name: "Lake Titicaca",
  latitude: 15.794896,
  longitude: 69.474792
)
place2 = Place.create!(
  name: "Lake Ashinoko",
  latitude: 35.18945,
  longitude: 135.999264
)
place3 = Place.create!(
  name: "Lake Biwako",
  latitude: 35.216494,
  longitude: 135.999264
)

place4 = Place.create!(
  name: "Lake Tamako",
  latitude: 35.762888,
  longitude: 139.439743
)


puts "Finished! Created #{Place.count} place(s)."

trip1 = Trip.new(
  date: Date.today,
  plan: <<~MARKDOWN
    # Lake Titicaca High-Altitude Fishing Trip Plan

    ## 1. Pre-Trip Prep (Day Before)
    * Acclimate to the high altitude (3,812 meters / 12,507 feet) in Puno or Copacabana for at least 24 hours.
    * Pack medium-action spinning rod, 8–12 lb monofilament or fluorocarbon line, and small spinners, spoons, or crankbaits (targeting rainbow trout and pejerrey).
    * Layer cold-weather clothing (thermal base layer, fleece, windproof jacket) and pack high-SPF sunscreen and lip balm.
    * Confirm local boat charter/guide, regional fishing permits, and pack altitude medication, water, and high-energy snacks.

    ## 2. Schedule
    * **05:30 AM:** Wake up, hydrate well, and eat a light breakfast.
    * **06:00 AM:** Meet your local guide at the dock (e.g., Puno Bay, Taquile, or Isla del Sol).
    * **06:30 AM:** Board the boat and head out to deep trolling zones or rocky drop-offs.
    * **07:00 AM:** Begin trolling and casting during calm morning water conditions.
    * **10:30 AM:** Break for coca tea, water, and snacks as the midday sun and high-altitude winds pick up.
    * **12:00 PM:** Clean kept trout/pejerrey (or prepare for a traditional shore lunch), pack up gear, and secure all trash.
    * **12:30 PM:** Return to the harbor.

    ## 3. Essential Gear Checklist
    - [ ] Medium-action rod & reel combo
    - [ ] Tackle box (silver/gold spinners, spoons, small crankbaits)
    - [ ] Polarized sunglasses (essential for intense high-altitude glare)
    - [ ] Sun hat, SPF 50+ sunscreen, and SPF lip balm
    - [ ] Layered windproof and warm clothing
    - [ ] Reusable water bottle, snacks, and altitude sickness remedies
    - [ ] Dry bag for electronics and permits
  MARKDOWN
)
trip1.user = user_annie
trip1.place = place1
trip1.save


trip2 = Trip.new(
  date: Date.today,
  plan: <<~MARKDOWN
    # Lake Ashi (Ashinoko) Trout & Black Bass Fishing Trip Plan

    ## 1. Pre-Trip Prep (Night Before)
    * Check Hakone mountain weather, fog advisories, and wind conditions (elevation is 723 meters / 2,372 feet, making mornings chilly even in mild seasons).
    * Pack medium-action spinning or baitcasting gear with 6–12 lb line, spoons, minnows, or soft plastics (targeting rainbow trout, brown trout, and largemouth bass).
    * Verify Ashinoko Fishing Cooperative rules: **recreational fishing license (*Yugyoken*) is mandatory** (available at local boathouses/convenience stores), and **strictly no soft-plastic worms/baits containing non-biodegradable materials** are allowed—use hard lures, flies, or approved eco-friendly baits only.
    * Check seasonal open dates (typically March 1 to December 14; closed during winter off-season).

    ## 2. Schedule
    * **05:00 AM:** Wake up, grab hot coffee, and load gear.
    * **05:30 AM:** Depart for Hakone (e.g., Moto-Hakone, Hakone-machi, or Kojiri boat docks).
    * **06:15 AM:** Purchase day fishing permit (*Yugyoken*), check in at the boathouse, and rig lures.
    * **06:30 AM:** Launch rowboat, motorboat, or set up along designated shoreline points (such as near Hakone Shrine or Kuzuryu Shrine waters) at opening bell.
    * **07:00 AM:** Cast and troll along rocky drop-offs and submerged structures during peak early-morning bite with Mt. Fuji views.
    * **10:30 AM:** Break for hot drinks and snacks as sightseeing pirate ships and lake winds pick up.
    * **12:00 PM:** Clean any kept trout (or practice catch-and-release), pack up all gear, and clear trash.
    * **12:30 PM:** Return boat to the dock and head to a nearby Hakone *onsen* or soba restaurant.

    ## 3. Essential Gear Checklist
    - [ ] Spinning or baitcasting rod & reel combo
    - [ ] Tackle box (spoons, sinking minnows, crankbaits, and spinnerbaits—no banned soft plastics)
    - [ ] Recreational fishing permit (*Yugyoken*) and waterproof holder
    - [ ] Polarized sunglasses, hat, and sunscreen
    - [ ] Layered windproof jacket (mountain temperatures drop quickly on the water)
    - [ ] Landing net, pliers, and stringer/cooler
    - [ ] Trash bag (leave no trace)
  MARKDOWN
)
trip2.user = user_paul
trip2.place = place2
trip2.save

trip3 = Trip.new(
  date: Date.today,
  plan: <<~MARKDOWN
    # Lake Biwa (Biwako) Bass & Biwa Trout Fishing Trip Plan

    ## 1. Pre-Trip Prep (Night Before)
    * Check Shiga Prefecture weather, wind warnings (especially strong afternoon *Hira-oroshi* mountain winds), and water levels.
    * Pack medium-heavy baitcasting rod (for largemouth bass around weed beds/piers) or light trolling/spinning gear (for Biwa trout), plus soft plastics, spinnerbaits, or spoons.
    * Verify local fishing rules (mandatory catch-and-release regulations for black bass and bluegill in Shiga Prefecture; no coastal fishing license needed for shore/recreational bass fishing, though boat charters and Biwa trout trolling require specific permits/reservations).
    * Pack cooler with drinks, snacks, rain gear, and polarised sunglasses.

    ## 2. Schedule
    * **05:00 AM:** Wake up, grab coffee, and load gear.
    * **05:30 AM:** Depart for Lake Biwa (e.g., Otsu, Kusatsu, or Katata marinas in the South Basin, or Nagahama/Takashima in the North Basin).
    * **06:00 AM:** Launch rental bass boat, board charter, or set up along shoreline piers/weed edges.
    * **06:30 AM:** Begin casting along submerged weed beds, bridges, and drop-offs during peak early-morning feeding.
    * **10:30 AM:** Take a break for snacks, hydration, and tackle adjustments as boat traffic and winds increase.
    * **12:00 PM:** Safely release any black bass/bluegill in accordance with local rules, pack up gear, and clear all trash.
    * **12:30 PM:** Return to the marina/parking area and head out for local lunch (e.g., Omi beef or lake fish dishes).

    ## 3. Essential Gear Checklist
    - [ ] Baitcasting or spinning rod & reel combo
    - [ ] Tackle box (Texas/wacky rig worms, jigs, spinnerbaits, or trolling spoons)
    - [ ] Pliers and fish gripper (for safe catch-and-release handling)
    - [ ] Polarized sunglasses, hat, and UV protection
    - [ ] Windbreaker / lightweight rain jacket
    - [ ] Cooler with water and snacks
    - [ ] Trash bag (leave no trace)
  MARKDOWN
)
trip3.user = user_jon
trip3.place = place3
trip3.save


trip4 = Trip.new(
  date: Date.today,
  plan: <<~MARKDOWN
    # Lake Tama (Tamako) Fishing & Lakeside Trip Plan

    > **Important Local Note:** Lake Tama (Murayama Reservoir) is a strictly protected drinking-water reservoir managed by the Tokyo Metropolitan Government Bureau of Waterworks. **Recreational fishing directly in Lake Tama is prohibited.** Anglers heading to the Tamako area either fish at nearby managed fishing ponds/parks (such as Seibuen Trout Fishing Area, open seasonally from autumn to spring) or pair a scenic lakeside walk/cycling trip around the Tamako Cycling Road with nearby Sayama/Iruma river fishing spots.

    ## 1. Pre-Trip Prep (Night Before)
    * Confirm whether you are visiting the **Seibuen Fishing Area** (seasonal managed trout pond right beside Lake Tama) or heading to nearby **Iruma/Tama River tributaries** for stream fishing.
    * Pack ultra-light area trout spinning gear (for managed ponds: 2–4 lb line, micro spoons under 2.5g, barbless single hooks) or light stream tackle.
    * Check venue rules: barbless single hooks only, strict prohibition on soft plastics/live bait at managed ponds, and valid day-ticket fees or river *Yugyoken* permits.
    * Pack comfortable walking/cycling shoes, light layers, and water/snacks.

    ## 2. Schedule
    * **06:00 AM:** Wake up, grab coffee, and pack gear.
    * **06:30 AM:** Depart for Higashimurayama / Tokorozawa area (accessible via Seibu Tamako Line or Seibu Sayama Line).
    * **07:30 AM:** Arrive near Lake Tama embankment, walk the scenic reservoir dam with views toward Mt. Fuji, and head to the adjacent managed trout area (or nearby river access).
    * **08:00 AM:** Purchase day pass, rig barbless micro spoons, and begin casting during cool morning water conditions.
    * **11:00 AM:** Break for snacks, coffee, and lure rotation as midday sunlight hits the water.
    * **12:30 PM:** Clean and pack any permitted catch (within pond ticket limits), pack up all tackle, and leave no trace.
    * **01:00 PM:** Wrap up with a walk or bike ride along the Tamako Cycling Road and grab lunch near Tamako or Seibu-Kyujo-mae Station.

    ## 3. Essential Gear Checklist
    - [ ] Ultra-light spinning rod & reel combo (2–4 lb line)
    - [ ] Area trout tackle box (micro spoons, mini crankbaits with **barbless single hooks**)
    - [ ] Silicone-mesh landing net & forceps/releaser (required for safe trout release)
    - [ ] Polarized sunglasses, hat, and sunscreen
    - [ ] Small cooler bag with ice packs (if keeping permitted pond trout)
    - [ ] Windbreaker and comfortable walking shoes
    - [ ] Trash bag (leave no trace)
  MARKDOWN
)
trip4.user = user_yoshi
trip4.place = place4
trip4.save

puts "Finished! Created #{Trip.count} trip(s)."

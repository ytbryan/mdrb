require 'mdrb'
require 'mdrb/version'

describe "MD" do
  it "0. MD.exist? is true" do 
    MD.create("zero", "# hello")
    expect(MD.exist?("zero")).to eq(true)
  end

  it "1. should have a version number" do 
    expect(MD::VERSION).not_to be_empty
  end

  it "2. create" do
    MD.create("first", "# hello")
    
    expect(MD.exist?("first")).to eq(true)
  end

  it "3. create many" do
    MD.create_many(["first", "second"], ["# first", "# second"])
    
    expect(MD.exist?("first")).to eq(true)
    expect(MD.exist?("second")).to eq(true)
  end

  it "4. read" do
    MD.create("first", "# first")
    
    expect(MD.read("first")).to eq("# first")
  end

  it "5. read many" do
    MD.create("first", "# first")
    MD.create("second", "# second")
    
    expect(MD.read_many(["first", "second"])).to eq([["# first"], ["# second"]])
  end

  it "6. delete" do
    MD.create("first", "# first")
    expect(MD.exist?("first")).to eq(true)
    
    MD.delete("first")
    expect(MD.exist?("first")).to eq(false)
  end

  it "7. delete many" do
    MD.create("first", "# first")
    MD.create("second", "# second")
    expect(MD.exist?("first")).to eq(true)
    expect(MD.exist?("second")).to eq(true)

    MD.delete_many(["first", "second"])
    expect(MD.exist?("first")).to eq(false)
    expect(MD.exist?("second")).to eq(false)
  end

  it "8. to_json" do
    MD.create("json", "# json")
    expect(MD.to_json("json")).to eq("{\"0\":\"# json\"}")
  end

  it "9. to_json_many" do
    MD.create("first", "# first")
    MD.create("second", "# second")

    expect(MD.to_json_many(["first", "second"])).to eq(["{\"0\":\"# first\"}", "{\"0\":\"# second\"}"])
  end

  it "10. update" do
    MD.create("first", "# first")
    MD.update("first", "# changed")

    expect(MD.exist?("first")).to eq(true)
    expect(MD.read("first")).to eq("# changed")
  end

  it "11. update many" do
    MD.create("first", "# first")
    MD.create("second", "# second")
    MD.update_many(["first", "second"], ["# second", "# first"])
    
    expect(MD.read("first")).to eq("# second")
    expect(MD.read("second")).to eq("# first")
  end

  it "12. move" do
    MD.create("first", "# first")
    MD.move("first", "second")    
    expect(MD.exist?("first")).to eq(false)
    expect(MD.exist?("second")).to eq(true)
  end


  it "13. move many" do
    MD.create("first", "# first")
    MD.create("second", "# second")

    MD.move_many(["first", "second"], ["third", "fourth"])    
    expect(MD.exist?("first")).to eq(false)
    expect(MD.exist?("second")).to eq(false)

    expect(MD.exist?("third")).to eq(true)
    expect(MD.exist?("fourth")).to eq(true)
  end


  after(:all) do
    MD.delete("zero") if MD.exist?("zero")
    MD.delete("json") if MD.exist?("json")
    MD.delete("first") if MD.exist?("first")
    MD.delete("second") if MD.exist?("second")
    MD.delete("third") if MD.exist?("third")
    MD.delete("fourth") if MD.exist?("fourth")

  end
end

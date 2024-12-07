require "test_helper"

class YoutubeLinkValidatorTest < ActiveSupport::TestCase
  setup do
    @validator = YoutubeLinkValidator
  end

  test "regular desktop link" do
    assert @validator.new("https://www.youtube.com/watch?v=dQw4w9WgXcQ").valid?
    assert @validator.new("https://youtube.com/watch?v=dQw4w9WgXcQ").valid?
    assert @validator.new("youtube.com/watch?v=dQw4w9WgXcQ").valid?
  end
  test "desktop link with params" do
    assert @validator.new("https://www.youtube.com/watch?v=dQw4w9WgXcQ&feature=shared").valid?
    assert @validator.new("https://www.youtube.com/watch?v=dQw4w9WgXcQ&feature=shared&t=10s").valid?
  end

  test "link of YouTube Music" do
    assert @validator.new("https://music.youtube.com/watch?v=XqoanTj5pNY&feature=shared").valid?
  end

  test "link from mobile browser" do
    assert @validator.new("https://m.youtube.com/watch?v=WZR1T1ywCzQ").valid?
    assert @validator.new("https://m.youtube.com/watch?v=XqoanTj5pNY&feature=shared").valid?
  end

  test "link from embed" do
    assert @validator.new("https://www.youtube.com/embed/3DGik5DRZWA?si=Pymb1_CR_RmvNcqN").valid?
  end

  test "invalid links" do
    assert_not @validator.new("https://www.youtube.com/watch?v=invalid").valid?
    assert_not @validator.new("https://www.you1123be.com/watch?v=dQw4w9WgXcQ&feature=shared&invalid").valid?
    assert_not @validator.new("").valid?
  end
end

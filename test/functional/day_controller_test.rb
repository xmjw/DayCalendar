require 'test_helper'

class DayControllerTest < ActionController::TestCase
  test "extracts day and count from params" do
    #arrange
    expected = {"tuesday12" => "ro bo", "tuesday13" => "ro to bo", "tuesday14" => "ro to bo", "tuesday15" => "ro to", "wednesday12" => "lo bo", "wednesday13" => "lo to bo", "wednesday14" => "lo to bo", "wednesday15" => "lo to"}

    #act
    slot_list = DayController.new.calculate_slots "tuesday12", "wednesday15"
    #assert
    puts slot_list

    assert(slot_list == expected,"Expected Output does not match actual")
  end
  test "assigns css classes to a surrounded square" do
    #Arrange
    left = 1
    right = 3
    top = 1
    bottom = 3
    currentX = 2
    currentY = 2

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert "lo ro to bo"==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "assigns css classes to a left edge" do
    #Arrange
    left = 1
    right = 3
    top = 1
    bottom = 3
    currentX = 1
    currentY = 2

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert "ro to bo"==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "assigns css classes to a right edge" do
    #Arrange
    left = 1
    right = 3
    top = 1
    bottom = 3
    currentX = 3
    currentY = 2

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert "lo to bo"==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "assigns css classes to a top edge" do
    #Arrange
    left = 1
    right = 3
    top = 1
    bottom = 3
    currentX = 2
    currentY = 1

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert "lo ro bo"==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "assigns css classes to a bottom edge" do
    #Arrange
    left = 1
    right = 3
    top = 1
    bottom = 3
    currentX = 2
    currentY = 3

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert "lo ro to"==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "assigns css classes to a horizontal bar" do
    #Arrange
    left = 1
    right = 3
    top = 1
    bottom = 1
    currentX = 2
    currentY = 1

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert "lo ro"==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "assigns css classes to a vertical bar" do
    #Arrange
    left = 1
    right = 1
    top = 1
    bottom = 3
    currentX = 1
    currentY = 2

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert "to bo"==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "assigns css classes to a lone blob" do
    #Arrange
    left = 1
    right = 1
    top = 1
    bottom = 1
    currentX = 1
    currentY = 1

    #Act
    result = DayController.new.find_css_class left, right, top, bottom, currentX, currentY

    #Assert
    assert ""==result, "assigned CSS classes were not as expected, got: |"+result+"|"
  end
  test "correctly identifies element above to have 'bo' class removed" do
    #Arrange
    lozenges = {"tuesday1" => "bo", "tuesday2" => "to"}
    toRemove = "tuesday2"
    toRemoveCSS = "to"
    #Act
    result = DayController.new.calculate_css_removal lozenges, toRemove, toRemoveCSS
    #Assert
    assert result == {"tuesday1" => "bo"}, "Calculated CSS Removal was incorrect."
  end
  
  test "correctly identifies element below to have 'to' class removed" do
    #Arrange
    lozenges = {"tuesday1" => "bo", "tuesday2" => "to"}
    toRemove = "tuesday1"
    toRemoveCSS = "bo"
    #Act
    result = DayController.new.calculate_css_removal lozenges, toRemove, toRemoveCSS
    #Assert
    assert result == {"tuesday2" => "to"}, "Calculated CSS Removal was incorrect."
  end
  
  test "correctly identifies element left to have 'ro' class removed" do
    #Arrange
    lozenges = {"friday3" => "ro", "saturday3" => "lo"}
    toRemove = "saturday3"
    toRemoveCSS = "lo"
    #Act
    result = DayController.new.calculate_css_removal lozenges, toRemove, toRemoveCSS
    #Assert
    assert result == {"friday3" => "ro"}, "Calculated CSS Removal was incorrect."
  end
  
  test "correctly identifies element right to have 'lo' class removed" do
    #Arrange
    lozenges = {"tuesday1" => "ro", "wednesday1" => "lo"}
    toRemove = "tuesday1"
    toRemoveCSS = "ro"
    #Act
    result = DayController.new.calculate_css_removal lozenges, toRemove, toRemoveCSS
    #Assert
    assert result == {"wednesday1" => "lo"}, "Calculated CSS Removal was incorrect."
  end
  
end

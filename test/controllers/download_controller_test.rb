require "test_helper"

class DownloadControllerTest < ActionDispatch::IntegrationTest
  test "should be successful with valid link" do
    get download_index_url, params: { link: "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }

    assert_response :success
  end

  test "should be unsuccessful with invalid link" do
    get download_index_url, params: { link: "https://www.youtube.com/watch?v=invalid" }

    assert_response :unprocessable_entity
  end

  test "should download file when it exists" do
    filename = "dummy.mp3"
    file_content = "dummy content"

    dl_path = Rails.root.join("public", "dl")
    FileUtils.mkdir_p(dl_path)
    File.write(dl_path.join(filename), file_content)

    get download_file_url(filename: filename)

    assert_response :success
    assert_equal file_content, response.body
  ensure
    FileUtils.rm_f(dl_path.join(filename))
  end

  test "should return 404 when file doesn't exist" do
    get download_file_url(filename: "nonexistent.mp4")

    assert_response :not_found
  end

  test "should reject paths trying to access parent directory" do
    get download_file_url(filename: "../dummy.mp3")

    assert_response :not_found
  end
end

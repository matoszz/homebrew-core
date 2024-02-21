class Datum < Formula
  desc "CLI for interacting with Datum's platform"
  homepage "https://docs.datum.net"
  url "https://github.com/datumforge/datum/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "f42b441592b858d63b09b2fa09eb35c84ce1b4e9d951d7e4b56e4a2cdea57120"
  license "Apache-2.0"
  head "https://github.com/datumforge/datum.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w -X github.com/datumforge/datum/internal/constants.CLIVersion=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/cli"

    generate_completions_from_executable(bin/"datum", "completion")
  end

  test do
    version_output = shell_output("#{bin}/datum version 2>&1 |head -n 1")
    assert_match "Version: #{version}", version_output
  end
end

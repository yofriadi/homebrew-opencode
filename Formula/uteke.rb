class Uteke < Formula
  desc "Persistent semantic memory and smart context management for AI agents"
  homepage "https://github.com/codecoradev/uteke"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/yofriadi/homebrew-tap/releases/download/uteke-0.10.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "bf95452a6c4da270ac1d0aadc31b1604f1b7d9f5d60e9579a011528db82f5cac"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/codecoradev/uteke/releases/download/v0.10.0/uteke-aarch64-apple-darwin-v0.10.0.tar.gz"
      sha256 "73cb262913b819e67babc72546eaaa79d5f15dbd16255c9ed57e05f7a2ec5324"
    else
      url "https://github.com/codecoradev/uteke/archive/refs/tags/v0.10.0.tar.gz"
      sha256 "2bbd25a322e55224e652c149a6855320541e8f5edeeeb7e2ece735a204aa16fd"
      depends_on "rust" => :build
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/codecoradev/uteke/releases/download/v0.10.0/uteke-aarch64-unknown-linux-gnu-v0.10.0.tar.gz"
      sha256 "47181c198ef70304b681025a326511c3e8467ce6044ab5ea11fb32941fcb22b7"
    else
      url "https://github.com/codecoradev/uteke/releases/download/v0.10.0/uteke-x86_64-unknown-linux-gnu-v0.10.0.tar.gz"
      sha256 "d091126c99ea3ccc40d64224280d856e05fa46b26a209a78a8d531061d179c7d"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      system "cargo", "install", *std_cargo_args(path: "crates/uteke-cli")
      system "cargo", "install", *std_cargo_args(path: "crates/uteke-server")
      system "cargo", "install", *std_cargo_args(path: "crates/uteke-mcp")
    else
      bin.install "uteke", "uteke-serve", "uteke-mcp"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uteke --version")
  end
end

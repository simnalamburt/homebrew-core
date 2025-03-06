class Goenv < Formula
  desc "Go version management"
  homepage "https://github.com/go-nv/goenv"
  url "https://github.com/go-nv/goenv/archive/refs/tags/2.2.21.tar.gz"
  sha256 "23566b4f09c1098c6a35668d31eb1ed4dec420040a8b4a4be158f08fecd760a7"
  license "MIT"
  version_scheme 1
  head "https://github.com/go-nv/goenv.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c1ae31004a1d84b4f15af508db0b8d0e8ffb6e9b06480619b0ffe9ca0edee734"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c1ae31004a1d84b4f15af508db0b8d0e8ffb6e9b06480619b0ffe9ca0edee734"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c1ae31004a1d84b4f15af508db0b8d0e8ffb6e9b06480619b0ffe9ca0edee734"
    sha256 cellar: :any_skip_relocation, sonoma:        "51e229e4eb39cc0c857ec5dc5a4d3427e8ffdcc1da27ca7e7e5c4716f46006bd"
    sha256 cellar: :any_skip_relocation, ventura:       "51e229e4eb39cc0c857ec5dc5a4d3427e8ffdcc1da27ca7e7e5c4716f46006bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1ae31004a1d84b4f15af508db0b8d0e8ffb6e9b06480619b0ffe9ca0edee734"
  end

  def install
    inreplace_files = [
      "libexec/goenv",
      "plugins/go-build/install.sh",
      "test/goenv.bats",
      "test/test_helper.bash",
    ]
    inreplace inreplace_files, "/usr/local", HOMEBREW_PREFIX

    prefix.install Dir["*"]
    %w[goenv-install goenv-uninstall go-build].each do |cmd|
      bin.install_symlink "#{prefix}/plugins/go-build/bin/#{cmd}"
    end
  end

  test do
    assert_match "Usage: goenv <command> [<args>]", shell_output("#{bin}/goenv help")
  end
end

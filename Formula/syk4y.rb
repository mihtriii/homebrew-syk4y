class Syk4y < Formula
  desc "Kaggle artifact automation command-line tool"
  homepage "https://github.com/TaiDuc1001/syk4y-apt"
  url "https://github.com/TaiDuc1001/syk4y-apt/archive/2fa40870a0abef91d05634c62c08a62f26de049b.tar.gz"
  version "0.0.15"
  sha256 "76badd767567e6ddc974d7153a665e8726b466d58d9451e7378f85517ab52294"

  depends_on "bash"

  def install
    libexec.install "syk4y", "syk4y-init", "syk4y-gen", "syk4y-kaggle", "syk4y-doctor", "syk4y-migrate-layout", "syk4y-update"
    libexec.install "syk4y-lib", "syk4y-cli-lib", "templates"

    command_targets = {
      "syk4y" => "syk4y",
      "syk4y-init" => "syk4y-init",
      "syk4y-gen" => "syk4y-gen",
      "syk4y-kaggle" => "syk4y-kaggle",
      "syk4y-doctor" => "syk4y-doctor",
      "syk4y-migrate-layout" => "syk4y-migrate-layout",
      "syk4y-update" => "syk4y-update",
      "make-gen-full-repo.sh" => "syk4y-gen",
    }

    command_targets.each do |command_name, target|
      (bin/command_name).write <<~EOS
        #!/bin/sh
        exec "#{Formula["bash"].opt_bin}/bash" "#{libexec}/#{target}" "$@"
      EOS
    end
  end

  test do
    assert_match "syk4y - Kaggle artifact automation tool", shell_output("#{bin}/syk4y --help")
  end
end

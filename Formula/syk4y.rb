class Syk4y < Formula
  desc "Kaggle artifact automation command-line tool"
  homepage "https://github.com/TaiDuc1001/syk4y-apt"
  url "https://github.com/TaiDuc1001/syk4y-apt/archive/196365a2e3c8310464d1cb06101ff5c783b566ee.tar.gz"
  version "0.0.16"
  sha256 "d379e8ff6ac1006a34bb47a47e0fdc3ed2e528a656307e5130191631ea9ec937"

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

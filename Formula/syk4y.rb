class Syk4y < Formula
  desc "Kaggle artifact automation command-line tool"
  homepage "https://github.com/TaiDuc1001/syk4y-apt"
  url "https://github.com/TaiDuc1001/syk4y-apt/archive/6e1128e293a6c557bfde08530c8482097c3eb41f.tar.gz"
  version "0.0.5"
  sha256 "0e9e045c284298a4bf0c515d2dac4aa13eb0909aef1f4a401365dcbd47828509"

  depends_on "bash"

  def install
    libexec.install "syk4y", "syk4y-init", "syk4y-gen", "syk4y-kaggle", "syk4y-doctor"
    libexec.install "syk4y-lib", "syk4y-cli-lib", "templates"

    command_targets = {
      "syk4y" => "syk4y",
      "syk4y-init" => "syk4y-init",
      "syk4y-gen" => "syk4y-gen",
      "syk4y-kaggle" => "syk4y-kaggle",
      "syk4y-doctor" => "syk4y-doctor",
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

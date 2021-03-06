require_relative '../handle_csv_from_excel'
require 'pp'

TEST_CSV_PATH = 'spec/test_CSV_from_読んだ本.csv' # セルの中に改行文字も入っているExcelから作った

describe '初期化' do
  let(:handler){HandleCsvFromExcel.new(TEST_CSV_PATH)}
  specify 'should be a valid object' do
    expect(handler).not_to be nil
  end
  it 'csvプロパティでCSVデータを保持する' do
    handler.csv.tap do |csv|
      expect(csv).not_to be nil
      expect(csv).to be_an CSV::Table
    end
  end
  let(:csv){handler.csv}
  it 'データの中に改行が入っていても、きちんと一つのデータとしてくれている。' do
    expect(csv.size).to be 8
  end
  it 'ヘッダ行をうまく読み込めている' do
    csv.headers.tap do |h|
      expect(h).not_to be nil
      expect(h).to be_an Array
      expect(h.first).to eq '読了日'
      expect(h.last).to eq 'コメント'
    end
  end
  it 'データ行も正しく読み込めている' do
    csv[0].tap do |first|
      expect(first['タイトル']).to eq '地層捜査'
      expect(first['評価']).to eq '3' # 数字も文字列として読み込む。
    end
  end
end
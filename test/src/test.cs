// C#: クラス、プロパティ、アトリビュート、LINQ、ジェネリクスの確認用
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EdoNezu.Theme.Testing
{
    [Serializable]
    public record TraditionalColor(int Id, string Name, string HexCode)
    {
        public bool IsWarmColor => HexCode.StartsWith("#cd") || HexCode.StartsWith("#b4");
    }

    /// <summary>
    /// 光学ピント制御テストクラス
    /// </summary>
    public class ColorValidator<T> where T : class, IDisposable
    {
        private const double GoldenRatio = 1.6180339887;
        private readonly List<TraditionalColor> _colors = new();

        public event EventHandler<string>? OnColorProcessed;

        public async Task<int> ProcessColorsAsync(IEnumerable<TraditionalColor> source)
        {
            // LINQ 構文とラムダ式
            var filtered = source
                .Where(c => c.Id > 0 && !string.IsNullOrEmpty(c.HexCode))
                .OrderBy(c => c.Name)
                .Select(c => new { c.Id, Formatted = $"Color: {c.Name} ({c.HexCode})" })
                .ToList();

            foreach (var item in filtered)
            {
                OnColorProcessed?.Invoke(this, item.Formatted);
                await Task.Delay(10);
            }

            return filtered.Count;
        }
    }
}

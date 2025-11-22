// Mock data for frontend demo
const students = [
  {id:1, roll:'CS2025-01', name:'Yallappa M Sanadi', course:'CSE', entry:'2025-11-01 08:05', exit:'2025-11-01 14:20', status:'present'},
  {id:2, roll:'CS2025-02', name:'Priya K', course:'ECE', entry:'2025-11-01 08:10', exit:'2025-11-01 14:15', status:'present'},
  {id:3, roll:'CS2025-03', name:'Rahul S', course:'MECH', entry:null, exit:null, status:'absent'},
  {id:4, roll:'CS2025-04', name:'Asha R', course:'CIVIL', entry:'2025-11-01 08:30', exit:'2025-11-01 14:00', status:'present'},
  {id:5, roll:'CS2025-05', name:'Deepak T', course:'CSE', entry:null, exit:null, status:'absent'},
  {id:6, roll:'CS2025-06', name:'Neha D', course:'ISE', entry:'2025-11-01 08:02', exit:'2025-11-01 14:05', status:'present'}
];

const menu = {
  Breakfast: ['Idli with chutney', 'Upma', 'Tea/Coffee'],
  Lunch: ['Steamed Rice', 'Dal Fry', 'Mixed Veg', 'Salad', 'Curd'],
  Dinner: ['Chapati', 'Paneer Curry', 'Rice', 'Raita']
};

function renderOverview(){
  const total = students.length;
  const present = students.filter(s=>s.status==='present').length;
  const absent = students.filter(s=>s.status==='absent').length;
  document.getElementById('totalStudents').textContent = total;
  document.getElementById('presentStudents').textContent = present;
  document.getElementById('absentStudents').textContent = absent;

  const recent = document.getElementById('recentActivity');
  recent.innerHTML = '';
  const top = students.slice(0,4);
  top.forEach(s=>{
    const d = document.createElement('div');
    d.className = 'p-3 bg-white rounded shadow-sm';
    d.innerHTML = `<div class="font-medium">${s.name} <span class="text-xs text-slate-500">(${s.roll})</span></div>
                   <div class="text-xs text-slate-500 mt-1">${s.status==='present' ? 'Entered at '+s.entry : 'Absent'}</div>`;
    recent.appendChild(d);
  });
}

function renderStudents(){
  const tbody = document.getElementById('studentsTbody');
  if(!tbody) return;
  const filter = document.getElementById('filterSelect').value;
  const q = document.getElementById('searchBox').value.toLowerCase();
  let list = students.slice();
  if(filter==='present') list = list.filter(s=>s.status==='present');
  if(filter==='absent') list = list.filter(s=>s.status==='absent');
  if(q) list = list.filter(s=> s.name.toLowerCase().includes(q) || s.roll.toLowerCase().includes(q));
  tbody.innerHTML = '';
  list.forEach(s=>{
    const tr = document.createElement('tr');
    tr.className = 'border-b';
    tr.innerHTML = `<td class="p-2 w-32">${s.roll}</td>
                    <td class="p-2">${s.name}</td>
                    <td class="p-2">${s.course}</td>
                    <td class="p-2">${s.entry || '-'}</td>
                    <td class="p-2">${s.exit || '-'}</td>`;
    tbody.appendChild(tr);
  });
}

function renderMenu(){
  const b = document.getElementById('breakfastList');
  const l = document.getElementById('lunchList');
  const d = document.getElementById('dinnerList');
  if(b) { b.innerHTML = menu.Breakfast.map(i=>'<li class="py-1">• '+i+'</li>').join(''); }
  if(l) { l.innerHTML = menu.Lunch.map(i=>'<li class="py-1">• '+i+'</li>').join(''); }
  if(d) { d.innerHTML = menu.Dinner.map(i=>'<li class="py-1">• '+i+'</li>').join(''); }
}

// Initialize on pages
document.addEventListener('DOMContentLoaded', function(){
  renderOverview();
  renderStudents();
  renderMenu();
});

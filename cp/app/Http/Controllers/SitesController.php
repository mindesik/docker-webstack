<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SitesController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->sites = glob('/etc/nginx/sites-available/*');
    }

    public function index()
    {
        return view('sites', [
            'sites' => $this->sites,
        ]);
    }
    
    public function store(Request $request)
    {
        if (!file_exists($request->input('path'))) {
            return [
                'error' => 'Directory not found',
            ];
        }
        
        $this->createSite($request->input('domain'), $request->input('path'));
    }
    
    public function destroy($domain)
    {
        exec(sprintf('sudo rm /etc/nginx/sites-available/%s', $domain));
        exec(sprintf('sudo service nginx restart'));
        exec(sprintf('sudo service php5-fpm restart'));
    }
    
    protected function createSite($domain, $path)
    {
        exec(sprintf('sudo serve %s %s', $domain, $path));
    }
}
